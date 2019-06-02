package com.plat.service;

import com.plat.dao.TrafficJoinMapper;
import com.plat.dao.TrafficMapper;
import com.plat.dao.TrafficTypeMapper;
import com.plat.entity.Page;
import com.plat.entity.Traffic;
import com.plat.entity.TrafficJoin;
import com.plat.entity.TrafficType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class TrafficServiceImpl implements TrafficService {

    @Autowired
    private TrafficMapper trafficMapper;

    @Autowired
    private TrafficTypeMapper trafficTypeMapper;

    @Autowired
    private TrafficJoinMapper trafficJoinMapper;

    public Page findList(String currPage) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = trafficMapper.getTotalCount();
        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));
        List<Traffic> list = trafficMapper.findPage(result.getBeginRows(),result.getPageSize());
        for(Traffic t : list){
            Date nowTime = new Date();
            if(nowTime.after(t.getEnd()))    //当前时间比截止时间提前
            {
                Traffic traffic = new Traffic();
                traffic.setId(t.getId());
                traffic.setFlag(1);      //假删除
                trafficMapper.updateByPrimaryKeySelective(traffic);
                list.remove(t);
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            t.setStartString(sdf.format(t.getStart()));
            t.setEndString(sdf.format(t.getEnd()));
        }
        result.setList(list);
        return result;
    }

    public List<TrafficType> findType() {
        return trafficTypeMapper.findAll();
    }

    @Override
    public int add(Traffic traffic) {
        traffic.setFlag(0);
        traffic.setJoinnum(0);
        return trafficMapper.insert(traffic);
    }

    @Override
    public int insert(TrafficJoin trafficJoin) {
        return trafficJoinMapper.insert(trafficJoin);
    }

    @Override
    public Page findMyList(String currPage, Integer uid) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = trafficMapper.getMyCount(uid);
        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));
        List<Traffic> list = trafficMapper.findMyPage(result.getBeginRows(),result.getPageSize(),uid);
        for(Traffic t : list){
            Date nowTime = new Date();
            if(nowTime.after(t.getEnd()))    //当前时间比截止时间提前
            {
                Traffic traffic = new Traffic();
                traffic.setId(t.getId());
                traffic.setFlag(1);      //假删除
                trafficMapper.updateByPrimaryKeySelective(traffic);
                list.remove(t);
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            t.setStartString(sdf.format(t.getStart()));
            t.setEndString(sdf.format(t.getEnd()));
        }
        result.setList(list);
        return result;
    }

    @Override
    public List<TrafficJoin> findCheckList(Integer tid) {
        return trafficJoinMapper.findListByTid(tid);
    }

    @Override
    public int update(TrafficJoin trafficJoin) {
        return trafficJoinMapper.updateByPrimaryKeySelective(trafficJoin);
    }

    @Override
    public List<TrafficJoin> findMyJoin(Integer uid) {
        return trafficJoinMapper.findMyJoin(uid);
    }
}
