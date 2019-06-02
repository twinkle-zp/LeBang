package com.plat.controller;

import com.alibaba.fastjson.JSON;
import com.plat.entity.Page;
import com.plat.entity.Resource;
import com.plat.entity.User;
import com.plat.service.ResourceService;
import com.plat.util.FlagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;

    @RequestMapping("/upload")
    public void uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String flag = "0";
        String name = request.getParameter("name");
        String desc = request.getParameter("desc");
        // 获取文件名
        String fileName = file.getOriginalFilename();
        // 获取扩展名
        String extensionName = fileName.substring(fileName.lastIndexOf(".") + 1);
        // 新的文件名 = 获取时间戳+"."图片扩展名
        String newFileName = String.valueOf(System.currentTimeMillis()) + "." + extensionName;
        //文件保存路径
        String filePath = request.getSession().getServletContext().getRealPath("/file/")+newFileName;
        File file1 = new File(filePath);
        try {
            file.transferTo(file1);
            User user = (User)request.getSession().getAttribute("user") ;
            Resource resource = new Resource();
            resource.setDescription(desc);
            resource.setUid(user.getUid());
            resource.setName(name);
            resource.setAddress("file/"+newFileName);
            resourceService.upload(resource);
            flag="1";
        } catch (IOException e) {
            flag="0";
            e.printStackTrace();
        }
        String json = JSON.toJSONString(flag);   //转成json数据
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        writer.write(json);
        writer.flush();
    }

    @RequestMapping("/findList")
    public String findList(HttpServletRequest request, HttpServletResponse response){
        String currPage = request.getParameter("currPage");//获取当前页
        Page page = resourceService.findList(currPage);
        request.setAttribute("page",page);
        return "jsp/resource";
    }

    @RequestMapping("/searchByName")
    public String searchByName(HttpServletRequest request, HttpServletResponse response){
        String name = request.getParameter("searchString");
        Page page = resourceService.findListByName(name);
        request.setAttribute("page",page);
        return "jsp/resource";
    }
    @RequestMapping("/download")
    public ResponseEntity<byte[]> fileDownLoad(HttpServletRequest request) throws Exception{
        String address = request.getParameter("address");
        String filePath = request.getSession().getServletContext().getRealPath("/"+address); //得到文件所在位置
        String fileName = request.getParameter("name");
        String id = request.getParameter("id");
        InputStream in=new FileInputStream(new File(filePath));//将该文件加入到输入流之中
        byte[] body=null;
        body=new byte[in.available()];// 返回下一次对此输入流调用的方法可以不受阻塞地从此输入流读取（或跳过）的估计剩余字节数
        in.read(body);//读入到输入流里面

        fileName=new String(fileName.getBytes("gbk"),"iso8859-1");//防止中文乱码
        HttpHeaders headers=new HttpHeaders();//设置响应头
        headers.add("Content-Disposition", "attachment;filename="+fileName);
        HttpStatus statusCode = HttpStatus.OK;//设置响应吗
        ResponseEntity<byte[]> response=new ResponseEntity<byte[]>(body, headers, statusCode);
        resourceService.addNum(Integer.valueOf(id)); //下载数加一
        return response;
    }

    @RequestMapping("/myResource")
    public String myResource(HttpServletRequest request, HttpServletResponse response){
        String currPage = request.getParameter("currPage");//获取当前页
        User user = (User)request.getSession().getAttribute("user");
        Page page = resourceService.findMyList(currPage,user.getUid());
        request.setAttribute("page",page);
        return "jsp/resource_my";
    }

    @RequestMapping("/delete")
    public String delete(HttpServletRequest request, HttpServletResponse response){
        String id = request.getParameter("id");
        String address = request.getParameter("address");
        String filePath = request.getSession().getServletContext().getRealPath("/"+address); //得到文件所在位置
        File file = new File(filePath);
        if (!file.exists()) {
            System.out.println("删除文件失败:" + filePath + "不存在！");
            return "error";
        }
        else {
            if(file.delete()){
                System.out.println("删除单个文件" + filePath + "成功！");
            }
            else {
                System.out.println("删除单个文件" + filePath + "失败！");
                return "error";
            }
        }
        resourceService.delete(Integer.valueOf(id));
        return "redirect:/resource/myResource";
    }

    @RequestMapping("/findAllList")
    public String findAllList(HttpServletRequest request, HttpServletResponse response){
        String currPage = request.getParameter("currPage");//获取当前页
        Page page = resourceService.findAllList(currPage);
        request.setAttribute("page",page);
        return "system/resource-list";
    }

    /**
     * 管理员审核资源
     */
    @ResponseBody
    @RequestMapping("/updateState")
    public FlagUtils updateFlag(HttpServletRequest request, HttpServletResponse response, Model model){
        String id = request.getParameter("id");//获取当前页
        String state = request.getParameter("state");
        FlagUtils flagUtils = new FlagUtils();
        Resource resource = new Resource();
        resource.setId(Integer.valueOf(id));
        if(Integer.valueOf(state)==0)
        {
            resource.setState(1);
        }
        else
        {
            resource.setState(0);
        }
        flagUtils.setFlag(resourceService.updateResource(resource));
        return flagUtils;
    }

    /**
     * 管理员删除帖子
     */
    @ResponseBody
    @RequestMapping("/deleteByAdmin")
    public FlagUtils deleteByAdmin(HttpServletRequest request, HttpServletResponse response, Model model){
        FlagUtils flagUtils = new FlagUtils();
        String id = request.getParameter("id");//获取当前页
        String address = request.getParameter("address");
        String filePath = request.getSession().getServletContext().getRealPath("/"+address); //得到文件所在位置
        File file = new File(filePath);
        if (!file.exists()) {
            System.out.println("删除文件失败:" + filePath + "不存在！");
            flagUtils.setFlag(0);
        }
        else {
            if(file.delete()){
                System.out.println("删除单个文件" + filePath + "成功！");
            }
            else {
                System.out.println("删除单个文件" + filePath + "失败！");
                flagUtils.setFlag(0);
            }
        }
        resourceService.delete(Integer.valueOf(id));
        flagUtils.setFlag(1);
        return flagUtils;
    }
}
