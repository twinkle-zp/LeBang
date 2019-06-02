package com.plat.dao;

import com.plat.entity.Traffic;

import java.util.List;

public interface TrafficMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Traffic record);

    int insertSelective(Traffic record);

    Traffic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Traffic record);

    int updateByPrimaryKey(Traffic record);

    int getTotalCount();

    List<Traffic> findPage(Integer beginRows, Integer pageSize);

    int getMyCount(Integer uid);

    List<Traffic> findMyPage(Integer beginRows, Integer pageSize, Integer uid);
}