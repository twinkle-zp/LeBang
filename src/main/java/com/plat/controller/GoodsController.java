package com.plat.controller;

import com.plat.entity.Goods;
import com.plat.entity.Message;
import com.plat.entity.Page;
import com.plat.entity.User;
import com.plat.service.GoodsService;
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
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @RequestMapping("/add")
    public String add(@RequestParam("img") MultipartFile img, HttpServletRequest request, HttpServletResponse response){

        Goods goods = new Goods();
        goods.setName(request.getParameter("name"));
        goods.setDescription(request.getParameter("desc"));
        goods.setPrice(Double.parseDouble(request.getParameter("price")));
        // 获取图片的文件名
        String fileName = img.getOriginalFilename();
        // 获取图片的扩展名
        String extensionName = fileName.substring(fileName.lastIndexOf(".") + 1);
        // 新的图片文件名 = 获取时间戳+"."图片扩展名
        String newFileName = String.valueOf(System.currentTimeMillis()) + "." + extensionName;
        //文件保存路径
        String filePath = request.getSession().getServletContext().getRealPath("/goodsimg/")+newFileName;

        goods.setImage("goodsimg/"+newFileName);
        User user = (User)request.getSession().getAttribute("user");
        goods.setUserId(user.getUid());
        goodsService.add(goods);
        File file = new File(filePath);
        try {
            img.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/goods/findGoodList";
    }

    @RequestMapping("/findGoodList")
    public String findList(HttpServletRequest request, HttpServletResponse response, Model model){

        String currPage = request.getParameter("currPage");
        Page page = goodsService.findList(currPage);
        request.setAttribute("page",page);
        //model.addAttribute("page",page);
        User user = (User)request.getSession().getAttribute("user");
        request.setAttribute("userId",String.valueOf(user.getUid()));
        return "jsp/goods";
    }

    @RequestMapping("/findGoodsById")
    public String findGoods(HttpServletRequest request, HttpServletResponse response, Model model){

        String id = request.getParameter("id");
        Goods goods = goodsService.findById(Integer.valueOf(id));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        goods.setDateString(sdf.format(goods.getDate()));
        request.setAttribute("goods",goods);
        //model.addAttribute("page",page);
        return "jsp/goods_info";
    }

    /**
     * 获取当前用户的商品
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/myGoods")
    public String myGoods(HttpServletRequest request, HttpServletResponse response, Model model){

        String currPage = request.getParameter("currPage");
        User user = (User)request.getSession().getAttribute("user");
        Page page = goodsService.findMyGoods(currPage,user.getUid());
        request.setAttribute("page",page);
        //model.addAttribute("page",page);

        request.setAttribute("userId",String.valueOf(user.getUid()));
        return "jsp/goods";
    }

    /**
     * 下架商品
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/delete")
    public String delete(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");
        goodsService.delete(Integer.valueOf(id));
        return "redirect:/goods/myGoods";
    }
    /**
     * 联系卖家留言
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/contact")
    public String contact(HttpServletRequest request, HttpServletResponse response, Model model){

        String goodId = request.getParameter("id");
        User user = (User)request.getSession().getAttribute("user");//获取当前用户
        List<Message> list = goodsService.findMessage(Integer.valueOf(goodId),user.getUid());
        request.setAttribute("userId",user.getUid());
        request.setAttribute("message",list);
        request.setAttribute("goodId",goodId);
        return "jsp/contact";
    }

    /**
     * 用户留言
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/addMessage")
    public String addMessage(HttpServletRequest request, HttpServletResponse response, Model model){
        String message = request.getParameter("message");
        String goodId = request.getParameter("goodId");
        String toId = request.getParameter("toId");
        String fromId = request.getParameter("fromId");
        User user = (User)request.getSession().getAttribute("user");
        if(fromId==""){   //未发过消息，第一次发消息
            Goods goods = goodsService.findById(Integer.valueOf(goodId));
            fromId = String.valueOf(goods.getUserId());
            toId = String.valueOf(goods.getUserId());
        }
        Integer userId = user.getUid();//获取当前用户ID
        Message message1 = new Message();
        message1.setContent(message);
        message1.setFromId(userId);
        message1.setGoodId(Integer.valueOf(goodId));
        if(userId==Integer.valueOf(toId))//若当前用户ID等于toId，则另一个用户ID为fromId
        {
            message1.setToId(Integer.valueOf(fromId));
            toId=fromId;
        }
        else
        {
            message1.setToId(Integer.valueOf(toId));
        }
        goodsService.addMessage(message1);
        return "redirect:/goods/findUserMessage?id="+goodId+"&toUserId="+toId;
    }

    /**
     * 获取当前用户与其他用户的留言列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/myMessage")
    public String myMessage(HttpServletRequest request, HttpServletResponse response, Model model){
        User user = (User)request.getSession().getAttribute("user");
        List<Message> messagesList = goodsService.findMessageList(user.getUid());
        request.setAttribute("messageList",messagesList);
        return "jsp/messageList";
    }

    /**
     * 获取当前用户与其他用户的详细留言
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/findUserMessage")
    public String findMessage(HttpServletRequest request, HttpServletResponse response, Model model){
        String goodId = request.getParameter("id");
        String toUserId = request.getParameter("toUserId");
        User user = (User)request.getSession().getAttribute("user");//获取当前用户
        List<Message> list = goodsService.findUserMessage(Integer.valueOf(goodId),user.getUid(),Integer.valueOf(toUserId));
        request.setAttribute("userId",user.getUid());
        request.setAttribute("message",list);
        request.setAttribute("goodId",goodId);
        return "jsp/contact";
    }

    /**
     *  根据商品名模糊搜索
     */
    @RequestMapping("/searchByName")
    public String searchByName(HttpServletRequest request, HttpServletResponse response, Model model){

        String name = request.getParameter("searchString");
        String currPage = request.getParameter("currPage");
        Page page = goodsService.findListByName(name);
        request.setAttribute("page",page);
        //model.addAttribute("page",page);
        User user = (User)request.getSession().getAttribute("user");
        request.setAttribute("userId",String.valueOf(user.getUid()));
        return "jsp/goods";
    }

    /**
     * 后台管理获取全部商品列表
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/findAllList")
    public String findAllList(HttpServletRequest request, HttpServletResponse response, Model model){

        String currPage = request.getParameter("currPage");
        Page page = goodsService.findAllList(currPage);
        request.setAttribute("page",page);
        //model.addAttribute("page",page);
        return "system/goods-list";
    }

    /**
     * 展示/禁止 商品
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/updateFlag")
    public void updateFlag(HttpServletRequest request, HttpServletResponse response, Model model) {
        String id = request.getParameter("id");
        String flag = request.getParameter("flag");
        goodsService.updateFlag(Integer.valueOf(id),Integer.valueOf(flag));
    }

    /**
     * 管理员删除商品
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/deleteByAdmin")
    public void deleteByAdmin(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");
        goodsService.deleteByAdmin(Integer.valueOf(id));
    }
}
