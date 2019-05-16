package com.plat.service;

import com.plat.entity.Article;
import com.plat.entity.ArticleComment;
import com.plat.entity.ArticleType;
import com.plat.entity.Page;

import java.util.List;

public interface ForumService {

    //查找帖子所有类别
    List<ArticleType> findType();

    //新增帖子
    void add(Article article);

    //分页查找帖子列表
    Page findList(String currPage);

    Article findArticleById(Integer id);

    List<ArticleComment> findCommentList(Integer aid);
}
