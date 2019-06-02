package com.plat.dao;

import com.plat.entity.TrafficJoin;

import java.util.List;

public interface TrafficJoinMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TrafficJoin record);

    int insertSelective(TrafficJoin record);

    TrafficJoin selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TrafficJoin record);

    int updateByPrimaryKey(TrafficJoin record);

    List<TrafficJoin> findListByTid(Integer tid);

    List<TrafficJoin> findMyJoin(Integer uid);
}