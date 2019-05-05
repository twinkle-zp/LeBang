package com.plat.dao;

import com.plat.entity.Activity;

import java.util.List;

public interface ActivityMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Activity record);

    int insertSelective(Activity record);

    Activity selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Activity record);

    int updateByPrimaryKeyWithBLOBs(Activity record);

    int updateByPrimaryKey(Activity record);

    int getTotalCount();

    List<Activity> findPage(Integer beginRows, Integer pageSize);
}