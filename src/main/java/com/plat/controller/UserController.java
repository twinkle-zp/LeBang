package com.plat.controller;

import com.plat.entity.Page;
import com.plat.entity.User;
import com.plat.service.UserService;
import com.plat.util.MyDateConverter;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @RequestMapping("/loginUser")
    public String loginUser()
    {
        return "jsp/login";
    }

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
                    return "jsp/Register";
                }
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
        else{
            request.setAttribute("errorMsg","验证码错误");
            return "jsp/Register";
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
            return "jsp/login";
        }
        if(state==1){
            request.setAttribute("errorPassword","密码错误");
            return "jsp/login";
        }
        //保存user到session
        User user = userService.findByUsername(username);
        request.getSession().setAttribute("user",user);
        return "redirect:/goods/findGoodList";
    }

    @RequestMapping("/exit")
    public String exit(HttpServletRequest request, HttpServletResponse response, Model model) {
        request.getSession().removeAttribute("user");
        return "jsp/login";
    }
    @ResponseBody
    @RequestMapping("/findName")
    public String findName(HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = (User) request.getSession().getAttribute("user");
        String username = user.getName();
        return username;
    }
    /**
     * 后台管理查找所有用户
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/findUserList")
    public String findUserList(HttpServletRequest request, HttpServletResponse response, Model model) {
        String currPage = request.getParameter("currPage");
        Page page = userService.findListByAdmin(currPage);
        request.setAttribute("page",page);
        return "system/user-list";
    }

    /**
     * 禁用/启用 用户
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/updateState")
    public void updateState(HttpServletRequest request, HttpServletResponse response, Model model) {
        String uid = request.getParameter("uid");
        String state = request.getParameter("state");
        userService.updateState(Integer.valueOf(uid),Integer.valueOf(state));
    }

    /**
     * 删除 用户
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/delete")
    public void delete(HttpServletRequest request, HttpServletResponse response, Model model) {
        String uid = request.getParameter("uid");
        userService.delete(Integer.valueOf(uid));
    }

    /**
     * 更新 用户信息
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/update")
    public void update(HttpServletRequest request, HttpServletResponse response, Model model) {
        String uid = request.getParameter("uid");
        String pass = request.getParameter("pass");
        String phone = request.getParameter("phone");
        User user = new User();
        user.setUid(Integer.valueOf(uid));
        user.setPassword(pass);
        user.setTelephone(phone);
        userService.update(user);
    }
}
