package com.plat.controller;

import com.alibaba.fastjson.JSON;
import com.plat.entity.*;
import com.plat.service.TrafficService;
import com.plat.util.DateUtils;
import com.plat.util.FlagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/traffic")
public class TrafficController {

    @Autowired
    private TrafficService trafficService;

    /**
     * 分页显示
     */
    @RequestMapping("/findList")
    public String findList(HttpServletRequest request, HttpServletResponse response, Model model){
        String currPage = request.getParameter("currPage");//获取当前页
        Page page = trafficService.findList(currPage);
        request.setAttribute("page",page);
        return "jsp/traffic";
    }
    @RequestMapping("/findType")
    public void findCategory(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        List<TrafficType> categoryList = trafficService.findType();
        String json = JSON.toJSONString(categoryList);
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        writer.write(json);
        writer.flush();
    }

    @ResponseBody
    @RequestMapping("/add")
    public FlagUtils add(HttpServletRequest request, HttpServletResponse response, Model model)  {
        FlagUtils flagUtils = new FlagUtils();
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        String neednum = request.getParameter("neednum");
        String phone = request.getParameter("phone");
        String type = request.getParameter("type");
        String content = request.getParameter("content");
        DateUtils dateUtils =new DateUtils();
        Date startTime = dateUtils.convert(start);     //转换时间格式
        Date endTime = dateUtils.convert(end);
        Traffic traffic = new Traffic();
        traffic.setStart(startTime);
        traffic.setEnd(endTime);
        traffic.setTid(Integer.valueOf(type));
        traffic.setContent(content);
        traffic.setNeednum(Integer.valueOf(neednum));
        traffic.setPhone(phone);
        User user = (User)request.getSession().getAttribute("user");
        traffic.setUid(user.getUid());
        flagUtils.setFlag(trafficService.add(traffic));
        return flagUtils;
    }

    @ResponseBody
    @RequestMapping("/join")
    public FlagUtils join(HttpServletRequest request, HttpServletResponse response, Model model)  {
        FlagUtils flagUtils = new FlagUtils();
        String trafficId= request.getParameter("id");
        String phone = request.getParameter("phone");
        String content = request.getParameter("content");
        User user = (User)request.getSession().getAttribute("user");
        TrafficJoin trafficJoin = new TrafficJoin();
        trafficJoin.setContent(content);
        trafficJoin.setTafficid(Integer.valueOf(trafficId));
        trafficJoin.setPhone(phone);
        trafficJoin.setUid(user.getUid());
        trafficJoin.setFlag(0);
        flagUtils.setFlag(trafficService.insert(trafficJoin));
        return flagUtils;
    }

    /**
     * 查找当前用户已发起的所有活动
     */
    @RequestMapping("/findMyList")
    public String myActivity(HttpServletRequest request, HttpServletResponse response, Model model){
        User user = (User)request.getSession().getAttribute("user");
        String currPage = request.getParameter("currPage");//获取当前页
        Page page = trafficService.findMyList(currPage,user.getUid());
        request.setAttribute("page",page);
        return "jsp/traffic_my";
    }

    /**
     * 查找当前活动的报名表
     */
    @RequestMapping("/findCheckList")
    public String findCheckList(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");
        List<TrafficJoin> trafficJoinList = trafficService.findCheckList(Integer.valueOf(id));
        request.setAttribute("tList",trafficJoinList);
        return "jsp/traffic_check";
    }

    /**
     * 审核报名表
     */
    @RequestMapping("/check")
    public String check(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");
        String flag = request.getParameter("flag");
        String tafficId= request.getParameter("tafficId");
        TrafficJoin trafficJoin = new TrafficJoin();
        trafficJoin.setId(Integer.valueOf(id));
        if(flag.equals("0")){
            trafficJoin.setFlag(0); //审核未通过
            trafficService.update(trafficJoin);
        }
        else{
            trafficJoin.setFlag(1); //审核未通过
            trafficService.update(trafficJoin);
        }
        return "redirect:/traffic/findCheckList?id="+tafficId;
    }

    /**
     * 查找当前用户已报名的活动
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/findMyJoin")
    public String findMyJoin(HttpServletRequest request, HttpServletResponse response, Model model){
        User user = (User) request.getSession().getAttribute("user");
        List<TrafficJoin> trafficJoinList = trafficService.findMyJoin(user.getUid());
        request.setAttribute("trafficJoinList",trafficJoinList);
        return "jsp/traffic_join_list";
    }
}
