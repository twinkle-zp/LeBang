package com.plat.controller;

import com.alibaba.fastjson.JSON;
import com.plat.entity.*;
import com.plat.service.ActivityService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/activity")
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    /**
     * ajax查找活动类别返回json至前端
     * @param request
     * @param response
     * @param model
     * @throws IOException
     */
    @RequestMapping("/findCategory")
    public void findCategory(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        List<ActivityCategory> categoryList = activityService.findAll();
        String json = JSON.toJSONString(categoryList);
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        writer.write(json);
        writer.flush();
    }

    @RequestMapping("/add")
    public String add(HttpServletRequest request, HttpServletResponse response, Model model){
        String name = request.getParameter("name");
        String categoryid = request.getParameter("category");
        String address = request.getParameter("address");
        String content = request.getParameter("content");
        User user = (User)request.getSession().getAttribute("user");
        Activity activity = new Activity();
        activity.setUid(user.getUid());
        activity.setCid(Integer.valueOf(categoryid));
        activity.setAddress(address);
        activity.setName(name);
        activity.setContent(content);
        activityService.add(activity);
        return "redirect:/activity/findList";
    }

    /**
     * 查找所有活动分页显示
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/findList")
    public String findList(HttpServletRequest request, HttpServletResponse response, Model model){
        String currPage = request.getParameter("currPage");//获取当前页
        Page page = activityService.findList(currPage);
        request.setAttribute("page",page);
        return "jsp/activity";

    }

    /**
     * 跳转到报名页面
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/joinPage")
    public String joinPage(HttpServletRequest request, HttpServletResponse response, Model model){
        String activityId = request.getParameter("activityId");
        request.setAttribute("activityId",activityId);
        return "jsp/join_activity";
    }
    /**
     * 提交报名表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/join")
    public String join(HttpServletRequest request, HttpServletResponse response, Model model){
        String activityId = request.getParameter("activityId");
        String contact = request.getParameter("contact");
        String content = request.getParameter("content");
        User user = (User)request.getSession().getAttribute("user");
        ActivityJoin activityJoin = new ActivityJoin();
        activityJoin.setAid(Integer.valueOf(activityId));
        activityJoin.setContact(contact);
        activityJoin.setContent(content);
        activityJoin.setFlag(0);//0为存在标记，1为已删除
        activityJoin.setState(0);//0为未审核
        activityJoin.setUid(user.getUid());
        activityJoin.setName(user.getName());
        activityService.join(activityJoin);
        return "redirect:/activity/findList";
    }

    /**
     * 查找当前用户已报名的活动
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/myJoinActivity")
    public String myJoinActivity(HttpServletRequest request, HttpServletResponse response, Model model){
        User user = (User) request.getSession().getAttribute("user");
        List<ActivityJoin> activityJoinList = activityService.findMyJoin(user.getUid());
        request.setAttribute("activityJoinList",activityJoinList);
        return "jsp/my_join_activity";
    }

    /**
     * 查找当前用户已发起的所有活动
     */
    @RequestMapping("/myActivity")
    public String myActivity(HttpServletRequest request, HttpServletResponse response, Model model){
        User user = (User) request.getSession().getAttribute("user");
        List<Activity> activityList = activityService.findMyActivity(user.getUid());
        request.setAttribute("activityList",activityList);
        return "jsp/my_activity";
    }

    /**
     * 查找当前活动的报名列表
     */
    @RequestMapping("/joinList")
    public String joinList(HttpServletRequest request, HttpServletResponse response, Model model){
        String activityId = request.getParameter("activityId");
        List<ActivityJoin> activityJoinList = activityService.findJoinList(Integer.valueOf(activityId));
        request.setAttribute("activityJoinList",activityJoinList);
        return "jsp/activity_join_check";
    }

    /**
     * 审核报名表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/check")
    public String check(HttpServletRequest request, HttpServletResponse response, Model model){
        String activityJoinId = request.getParameter("activityJoinId");
        String state = request.getParameter("state");
        String activityId= request.getParameter("activityId");
        if(state.equals("0")){
            activityService.check(0,Integer.valueOf(activityJoinId));  //审核未通过
        }
        else{
            activityService.check(1,Integer.valueOf(activityJoinId));
        }
        return "redirect:/activity/joinList?activityId="+activityId;
    }
}
