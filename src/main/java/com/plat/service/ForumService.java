package com.plat.service;

import com.plat.entity.*;

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

    void addComment(Integer article_id, String content, Integer uid);

    List<ArticleMulti> findMultiList(Integer comment_id);
}
