package com.plat.controller;

import com.alibaba.fastjson.JSON;
import com.plat.entity.*;
import com.plat.service.ForumService;
import com.plat.util.DateUtils;
import com.plat.util.FlagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("forum")
public class ForumController {

    @Autowired
    private ForumService forumService;

    /**
     * ajax查找帖子类别返回json至前端
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
        return "redirect:/forum/findList";
    }

    /**
     * 查找所有帖子分页显示
     */
    @RequestMapping("/findList")
    public String findList(HttpServletRequest request, HttpServletResponse response, Model model){
        String currPage = request.getParameter("currPage");//获取当前页
        Page page = forumService.findList(currPage);
        request.setAttribute("page",page);
        return "jsp/forum";

    }

    /**
     * 查找所有帖子详细信息
     */
    @RequestMapping("/findDetail")
    public String findDetail(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");//获取当前帖子id
        Article article = forumService.findArticleById(Integer.valueOf(id));
        List<ArticleComment> articleCommentList = forumService.findCommentList(Integer.valueOf(id));
        request.setAttribute("article",article);
        request.setAttribute("commentList",articleCommentList);
        return "jsp/forum_detail";

    }

    /**
     * 帖子一级回复
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
     * 帖子一级回复
     */
    @ResponseBody
    @RequestMapping("/addMulti")
    public FlagUtils addMulti(HttpServletRequest request, HttpServletResponse response, Model model){
        FlagUtils flagUtils = new FlagUtils();
        String comid = request.getParameter("comId");//获取当前帖子id
        String content = request.getParameter("content");
        User user = (User)request.getSession().getAttribute("user");
        flagUtils.setFlag(forumService.addMulti(Integer.valueOf(comid),content,user.getUid()));
        return flagUtils;

    }
    /**
     * 查找当前回复的二级回复列表
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

    /**
     * 管理员查找所有帖子分页显示
     */
    @RequestMapping("/findAllList")
    public String findAllList(HttpServletRequest request, HttpServletResponse response, Model model){
        String currPage = request.getParameter("currPage");//获取当前页
        Page page = forumService.findAllList(currPage);
        request.setAttribute("page",page);
        return "system/article-list";
    }

    /**
     * 管理员禁用帖子展示
     */
    @ResponseBody
    @RequestMapping("/updateFlag")
    public FlagUtils updateFlag(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");//获取当前页
        String flag = request.getParameter("flag");
        FlagUtils flagUtils = new FlagUtils();
        Article article = new Article();
        article.setId(Integer.valueOf(id));
        if(Integer.valueOf(flag)==0)
        {
            article.setFlag(1);
        }
        else
        {
            article.setFlag(0);
        }
        flagUtils.setFlag(forumService.updateArticle(article));
        return flagUtils;
    }

    /**
     * 管理员删除帖子
     */
    @ResponseBody
    @RequestMapping("/deleteByAdmin")
    public FlagUtils deleteByAdmin(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");//获取当前页
        FlagUtils flagUtils = new FlagUtils();
        flagUtils.setFlag(forumService.deleteByAdmin(Integer.valueOf(id)));
        return flagUtils;
    }

    /**
     * 管理员查找类别列表
     */
    @RequestMapping("/findAllType")
    public String findAllType(HttpServletRequest request, HttpServletResponse response, Model model){
        List<ArticleType> typeList = forumService.findAllType();
        request.setAttribute("typeList",typeList);
        return "system/article-type-list";
    }

    /**
     * 管理员删除类别
     */
    @ResponseBody
    @RequestMapping("/deleteType")
    public FlagUtils deleteType(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");//获取当前页
        FlagUtils flagUtils = new FlagUtils();
        flagUtils.setFlag(forumService.deleteType(Integer.valueOf(id)));
        return flagUtils;
    }

    /**
     * 管理员添加类别
     */
    @ResponseBody
    @RequestMapping("/addType")
    public FlagUtils addType(HttpServletRequest request, HttpServletResponse response, Model model){
        String type = request.getParameter("type");//获取当前页
        FlagUtils flagUtils = new FlagUtils();
        ArticleType articleType = new ArticleType();
        articleType.setName(type);
        flagUtils.setFlag(forumService.addType(articleType));
        return flagUtils;
    }
}
