package com.plat.controller;

import com.plat.entity.Admin;
import com.plat.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @RequestMapping("/loginAdmin")
    public String loginAdmin(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "system/login";
    }
    @RequestMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        int state = adminService.login(username,password);
        if(state==0){
            request.setAttribute("errorUsername","用户名错误");
            return "system/login";
        }
        if(state==1){
            request.setAttribute("errorPassword","密码错误");
            return "system/login";
        }
        //保存user到session
        Admin admin = adminService.findByUsername(username);
        request.getSession().setAttribute("admin",admin);
        return "system/index";
    }
}
