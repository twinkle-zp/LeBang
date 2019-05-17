package com.plat.service;

import com.plat.dao.ArticleCommentMapper;
import com.plat.dao.ArticleMapper;
import com.plat.dao.ArticleMultiMapper;
import com.plat.dao.ArticleTypeMapper;
import com.plat.entity.*;
import com.plat.util.DateUtils;
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

    @Autowired
    private ArticleMultiMapper articleMultiMapper;

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

    public void addComment(Integer article_id, String content, Integer uid) {
        ArticleComment articleComment = new ArticleComment();
        articleComment.setArtid(article_id);
        articleComment.setContent(content);
        articleComment.setUid(uid);
        articleComment.setFlag(0);
        articleComment.setNum(0);
        DateUtils dateUtils = new DateUtils();
        articleComment.setTime(dateUtils.getNowTime());
        articleCommentMapper.insert(articleComment);
    }

    public List<ArticleMulti> findMultiList(Integer comment_id) {
        List<ArticleMulti> articleMultiList = articleMultiMapper.findMultiByCid(comment_id);
        return articleMultiList;
    }
}
