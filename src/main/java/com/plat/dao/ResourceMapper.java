package com.plat.dao;

import com.plat.entity.Resource;

import java.util.List;

public interface ResourceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Resource record);

    int insertSelective(Resource record);

    Resource selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Resource record);

    int updateByPrimaryKey(Resource record);

    int getTotalCount();

    List<Resource> findPage(Integer beginRows, Integer pageSize);

    int getMyTotalCount(Integer uid);

    List<Resource> findMyPage(Integer beginRows, Integer pageSize,Integer uid);

    int getAllCount();

    List<Resource> findAllPage(Integer beginRows, Integer pageSize);

    int getTotalCountByName(String name);

    List<Resource> findPageByName(Integer beginRows, Integer pageSize, String name);
}