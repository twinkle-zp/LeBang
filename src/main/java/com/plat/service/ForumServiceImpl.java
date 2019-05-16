package com.plat.service;

import com.plat.dao.ArticleCommentMapper;
import com.plat.dao.ArticleMapper;
import com.plat.dao.ArticleTypeMapper;
import com.plat.entity.Article;
import com.plat.entity.ArticleComment;
import com.plat.entity.ArticleType;
import com.plat.entity.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ForumServiceImpl implements ForumService {

    @Autowired
    private ArticleTypeMapper articleTypeMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private ArticleCommentMapper articleCommentMapper;

    public List<ArticleType> findType() {
        return articleTypeMapper.findAll();
    }

    public void add(Article article) {
        articleMapper.insert(article);
    }

    public Page findList(String currPage) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = articleMapper.getTotalCount();

        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));

        List<Article> list = articleMapper.findPage(result.getBeginRows(),result.getPageSize());
        result.setList(list);
        return result;
    }

    public Article findArticleById(Integer id) {
        return articleMapper.findDetail(id);
    }

    public List<ArticleComment> findCommentList(Integer aid) {

        return articleCommentMapper.findListByAid(aid);
    }
}
