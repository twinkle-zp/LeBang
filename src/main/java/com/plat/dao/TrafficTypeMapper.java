package com.plat.dao;

import com.plat.entity.TrafficType;

import java.util.List;

public interface TrafficTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TrafficType record);

    int insertSelective(TrafficType record);

    TrafficType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TrafficType record);

    int updateByPrimaryKey(TrafficType record);

    List<TrafficType> findAll();
}