package com.plat.service;

import com.plat.dao.ActivityCategoryMapper;
import com.plat.dao.ActivityJoinMapper;
import com.plat.dao.ActivityMapper;
import com.plat.entity.Activity;
import com.plat.entity.ActivityCategory;
import com.plat.entity.ActivityJoin;
import com.plat.entity.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityCategoryMapper activityCategoryMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ActivityJoinMapper activityJoinMapper;

    public List<ActivityCategory> findAll() {

        return activityCategoryMapper.findAll();
    }

    public void add(Activity activity) {
        activityMapper.insert(activity);
    }

    public Page findList(String currPage) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = activityMapper.getTotalCount();

        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));

        List<Activity> list = activityMapper.findPage(result.getBeginRows(),result.getPageSize());
        result.setList(list);
        return result;
    }

    public void join(ActivityJoin activityJoin) {
        activityJoinMapper.insert(activityJoin);
    }

    public List<ActivityJoin> findMyJoin(Integer uid) {
        return activityJoinMapper.findMyJoin(uid);
    }

    public List<Activity> findMyActivity(Integer uid) {
        List<Activity> activityList = activityMapper.findMyActivity(uid);
        for(Activity a:activityList){
            Integer num = activityJoinMapper.findNum(a.getId());
            a.setNum(num);
        }
        return activityList;
    }

    public List<ActivityJoin> findJoinList(Integer aid) {
        return activityJoinMapper.findJoinList(aid);
    }

    public void check(Integer state,Integer activityJoinId) {
        ActivityJoin activityJoin = new ActivityJoin();
        activityJoin.setId(activityJoinId);
        activityJoin.setState(state);
        activityJoinMapper.updateByPrimaryKeySelective(activityJoin);
    }
}
