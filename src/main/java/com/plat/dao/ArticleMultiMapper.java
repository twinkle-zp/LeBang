package com.plat.dao;

import com.plat.entity.ArticleMulti;

import java.util.List;

public interface ArticleMultiMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ArticleMulti record);

    int insertSelective(ArticleMulti record);

    ArticleMulti selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ArticleMulti record);

    int updateByPrimaryKey(ArticleMulti record);

    List<ArticleMulti> findMultiByCid(Integer comment_id);
}