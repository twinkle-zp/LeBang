package com.plat.dao;

import com.plat.entity.Goods;

import java.util.List;

public interface GoodsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Goods record);

    int insertSelective(Goods record);

    Goods selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Goods record);

    int updateByPrimaryKey(Goods record);

    int getTotalCount();

    List<Goods> findPage(Integer beginRows, Integer pageSize);

    int getMyTotalCount(Integer uid);

    List<Goods> findMyPage(Integer beginRows, Integer pageSize, Integer uid);

    int getAllCount();

    List<Goods> findAllPage(Integer beginRows, Integer pageSize);

    int getTotalCountByName(String name);

    List<Goods> findPageByName(Integer beginRows, Integer pageSize, String name);
}