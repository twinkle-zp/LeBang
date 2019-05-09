package com.plat.dao;

import com.plat.entity.ActivityJoin;

import java.util.List;

public interface ActivityJoinMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ActivityJoin record);

    int insertSelective(ActivityJoin record);

    ActivityJoin selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ActivityJoin record);

    int updateByPrimaryKey(ActivityJoin record);

    List<ActivityJoin> findMyJoin(Integer uid);

    Integer findNum(Integer id);//查找对应活动的报名人数

    List<ActivityJoin> findJoinList(Integer aid);
}