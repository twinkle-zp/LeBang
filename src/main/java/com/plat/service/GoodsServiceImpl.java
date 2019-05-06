package com.plat.service;

import com.plat.dao.GoodsMapper;
import com.plat.dao.MessageMapper;
import com.plat.entity.Goods;
import com.plat.entity.Message;
import com.plat.entity.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    @Autowired
    private MessageMapper messageMapper;

    public void add(Goods goods) {
        Date date = new Date();//获得系统时间.
        SimpleDateFormat sdf =   new SimpleDateFormat( " yyyy-MM-dd " );
        String nowTime = sdf.format(date);
        Date time = null;
        try {
            time = sdf.parse(nowTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        goods.setDate(time);
        goods.setFlag(0);
        int ok = goodsMapper.insert(goods);

    }

    public Page findList(String currPage) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = goodsMapper.getTotalCount();

        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));

        List<Goods> list = goodsMapper.findPage(result.getBeginRows(),result.getPageSize());
        result.setList(list);
        return result;
    }

    public Goods findById(Integer id) {
        return goodsMapper.selectByPrimaryKey(id);
    }

    public List<Message> findMessage(Integer goodId,Integer userId) {
        return messageMapper.findList(goodId,userId);
    }

    public void addMessage(Message message1) {
        //获取当前系统时间
        Date date = new Date();
        SimpleDateFormat sdt = new SimpleDateFormat(" yyyy-MM-dd HH:mm:ss ");
        String nowTime = sdt.format(date);
        try {
            Date time = sdt.parse(nowTime);
            message1.setDate(time);
            messageMapper.insert(message1);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public Page findMyGoods(String currPage, Integer uid) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = goodsMapper.getMyTotalCount(uid);

        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));

        List<Goods> list = goodsMapper.findMyPage(result.getBeginRows(),result.getPageSize(),uid);
        result.setList(list);
        return result;
    }

    public void delete(Integer id) {
        Goods goods = new Goods();
        goods.setId(id);
        goods.setFlag(1);//假删除，置flag为1
        goodsMapper.updateByPrimaryKeySelective(goods);
    }
}
