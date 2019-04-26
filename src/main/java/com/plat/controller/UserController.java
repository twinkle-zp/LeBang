package com.plat.controller;

import com.plat.entity.User;
import com.plat.service.UserService;
import com.plat.util.MyDateConverter;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/checkUsername")
    public String checkUsername(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
        String username = request.getParameter("username");
        User user = userService.findByUsername(username);
        if(user!=null){
            response.getWriter().write("1");
        }
        else{
            response.getWriter().write("0");
        }
        return null;
    }

    @RequestMapping("/register")
    public String register(HttpServletRequest request, HttpServletResponse response, Model model){
        //判断验证码是否正确
        String sessionYzm = (String) request.getSession().getAttribute("code");
        String yzm = request.getParameter("yzm");
        if(null!=yzm&&yzm.equals(sessionYzm)) {
            User user = new User();
            try {
                ConvertUtils.register(new MyDateConverter(), Date.class);//日期转换
                BeanUtils.populate(user,request.getParameterMap());//表单数据转为user对象
                boolean ok = userService.register(user);
                if(!ok){
                    request.setAttribute("errorMsg","注册失败");
                    return "Register";
                }
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
        else{
            request.setAttribute("errorMsg","验证码错误");
            return "Register";
        }
        return "redirect:/login.jsp";
    }

    @RequestMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response, Model model) {

        String username=request.getParameter("username");
        String password=request.getParameter("password");
        int state = userService.login(username,password);
        if(state==0){
            request.setAttribute("errorUsername","用户名错误");
            return "login";
        }
        if(state==1){
            request.setAttribute("errorPassword","密码错误");
            return "login";
        }
        //保存user到session
        User user = userService.findByUsername(username);
        request.getSession().setAttribute("user",user);
        return "redirect:/goods/findGoodList";
    }
}
