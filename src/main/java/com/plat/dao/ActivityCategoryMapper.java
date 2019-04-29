package com.plat.dao;

import com.plat.entity.ActivityCategory;

import java.util.List;

public interface ActivityCategoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ActivityCategory record);

    int insertSelective(ActivityCategory record);

    ActivityCategory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ActivityCategory record);

    int updateByPrimaryKey(ActivityCategory record);

    List<ActivityCategory> findAll();
}