package com.plat.dao;

import com.plat.entity.Article;

import java.util.List;

public interface ArticleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Article record);

    int insertSelective(Article record);

    Article selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Article record);

    int updateByPrimaryKeyWithBLOBs(Article record);

    int updateByPrimaryKey(Article record);

    int getTotalCount();

    List<Article> findPage(Integer beginRows, Integer pageSize);

    Article findDetail(Integer id);

    int getAllCount();

    List<Article> findAllPage(Integer beginRows, Integer pageSize);
}