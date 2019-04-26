package com.plat.controller;

import com.plat.entity.Goods;
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
        return "index";
    }

    @RequestMapping("/findGoodList")
    public String findList(HttpServletRequest request, HttpServletResponse response, Model model){

        String currPage = request.getParameter("currPage");
        Page page = goodsService.findList(currPage);
        request.setAttribute("page",page);
        //model.addAttribute("page",page);
        return "goods";
    }

    @RequestMapping("/findGoodsById")
    public String findGoods(HttpServletRequest request, HttpServletResponse response, Model model){

        String id = request.getParameter("id");
        Goods goods = goodsService.findById(Integer.valueOf(id));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        goods.setDateString(sdf.format(goods.getDate()));
        request.setAttribute("goods",goods);
        //model.addAttribute("page",page);
        return "goods_info";
    }


}
