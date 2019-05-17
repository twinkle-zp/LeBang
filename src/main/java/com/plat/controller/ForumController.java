package com.plat.controller;

import com.alibaba.fastjson.JSON;
import com.plat.entity.*;
import com.plat.service.ForumService;
import com.plat.util.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("forum")
public class ForumController {

    @Autowired
    private ForumService forumService;

    /**
     * ajax查找帖子类别返回json至前端
     * @param request
     * @param response
     * @param model
     * @throws IOException
     */
    @RequestMapping("/findCategory")
    public void findCategory(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        List<ArticleType> categoryList = forumService.findType();
        String json = JSON.toJSONString(categoryList);   //转成json数据
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        writer.write(json);
        writer.flush();
    }

    /**
     * 帖子上传
     * @param img
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/add")
    public String add(@RequestParam("img") MultipartFile img, HttpServletRequest request, HttpServletResponse response){

        Article article = new Article();
        String categoryid = request.getParameter("category");
        article.setTid(Integer.valueOf(categoryid));
        article.setTitle(request.getParameter("name"));
        article.setContent(request.getParameter("content"));

        // 获取图片的文件名
        String fileName = img.getOriginalFilename();
        // 获取图片的扩展名
        String extensionName = fileName.substring(fileName.lastIndexOf(".") + 1);

        if(extensionName.equals("jpg")||extensionName.equals("png")||extensionName.equals("gif"))//判断上传的文件是否是图片
        {
            // 新的图片文件名 = 获取时间戳+"."图片扩展名
            String newFileName = String.valueOf(System.currentTimeMillis()) + "." + extensionName;
            //文件保存路径
            String filePath = request.getSession().getServletContext().getRealPath("/forumimg/")+newFileName;
            article.setImg("forumimg/"+newFileName);
            File file = new File(filePath);
            try {
                img.transferTo(file);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        User user = (User)request.getSession().getAttribute("user");
        article.setUid(user.getUid());
        DateUtils dateUtils = new DateUtils();
        article.setTime(dateUtils.getNowTime());
        article.setFlag(0);
        article.setNum(0);
        forumService.add(article);
        return null;
    }

    /**
     * 查找所有帖子分页显示
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/findList")
    public String findList(HttpServletRequest request, HttpServletResponse response, Model model){
        String currPage = request.getParameter("currPage");//获取当前页
        Page page = forumService.findList(currPage);
        request.setAttribute("page",page);
        return "forum";

    }

    /**
     * 查找所有帖子详细信息
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/findDetail")
    public String findDetail(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");//获取当前帖子id
        Article article = forumService.findArticleById(Integer.valueOf(id));
        List<ArticleComment> articleCommentList = forumService.findCommentList(Integer.valueOf(id));
        request.setAttribute("article",article);
        request.setAttribute("commentList",articleCommentList);
        return "forum_detail";

    }

    /**
     * 帖子一级回复
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/addComment")
    public String addComment(HttpServletRequest request, HttpServletResponse response, Model model){
        String article_id = request.getParameter("id");//获取当前帖子id
        String content = request.getParameter("content");
        User user = (User)request.getSession().getAttribute("user");
        forumService.addComment(Integer.valueOf(article_id),content,user.getUid());
        return "redirect:/forum/findDetail?id="+article_id;

    }

    /**
     * 查找当前回复的二级回复列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/findMulti")
    public void findMulti(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        String comment_id = request.getParameter("id");//获取当前回复id
        List<ArticleMulti> multiList = forumService.findMultiList(Integer.valueOf(comment_id));
        String json = JSON.toJSONString(multiList);   //转成json数据
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        writer.write(json);
        writer.flush();
    }
}
