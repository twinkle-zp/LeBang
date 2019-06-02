<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%--解决静态资源路径问题--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>">
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Product</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="Wish shop project">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
    <link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="styles/product.css">
    <link rel="stylesheet" type="text/css" href="styles/product_responsive.css">
    <link rel="stylesheet" href="layui/css/layui.css" media="all">

</head>
<body>

<div class="super_container">

    <!-- Header -->

    <jsp:include page="header.jsp"/>


    <!-- Menu -->

    <div class="menu d-flex flex-column align-items-end justify-content-start text-right menu_mm trans_400">
        <div class="menu_close_container"><div class="menu_close"><div></div><div></div></div></div>
        <div class="logo menu_mm"><a href="#">Wish</a></div>
        <div class="search">
            <form action="#">
                <input type="search" class="search_input menu_mm" required="required">
                <button type="submit" id="search_button_menu" class="search_button menu_mm"><img class="menu_mm" src="images/magnifying-glass.svg" alt=""></button>
            </form>
        </div>
        <nav class="menu_nav">
            <ul class="menu_mm">
                <li class="menu_mm"><a href="index.html">home</a></li>
                <li class="menu_mm"><a href="#">clothes</a></li>
                <li class="menu_mm"><a href="#">accessories</a></li>
                <li class="menu_mm"><a href="#">lingerie</a></li>
                <li class="menu_mm"><a href="#">contact</a></li>
            </ul>
        </nav>
    </div>

    <div class="resource_function" style="margin-top:150px;margin-left:400px">
        <button type="button" class="layui-btn" id="upload" onclick="upload()"><i class="layui-icon"></i>上传文件</button>
        <button type="button" class="layui-btn" onclick="window.location.href='resource/myResource'"><i class="layui-icon"></i>我上传的</button>
    </div>
    <div class="resource_display">
        <ul>
            <!-- Review -->
            <c:forEach items="${page.list}" var="p">
                <li class=" review clearfix">
                    <div class="review_content">
                        <div class="review_name">
                            <a href="javascript:void (0)" style="margin-left:80px;width: 400px" title="${p.description}">${p.name}${p.suffix}</a>
                            <div class="review_download">
                                <button type="button" class="layui-btn" style="margin-left: 400px" onclick="window.location.href='resource/delete?id=${p.id}&address=${p.address}&name=${p.name}${p.suffix}'">删除</button>
                            </div>
                        </div>
                        <div class="review_text" style="margin-top: 0px;margin-left: 80px">
                            <p>上传者：${p.uname}&nbsp;&nbsp;&nbsp;&nbsp;下载数：${p.num}</p>
                        </div>
                        <div class="review_text" style="margin-left: 80px;font-size: 20px">
                            <p>${p.description}</p>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div id="pagination" style="margin-left: 1200px">
        <c:forEach begin="1" end="${page.totalPage}" var="currPage">
            <a href="resource/myResource?currPage=${currPage}" <c:if test="${page.currPage == currPage}">class="btn active"</c:if> >${currPage}</a>
        </c:forEach>
    </div>

</div>
<script src="layui/layui.js" charset="utf-8"></script>
<script>
    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
        upload = function(){
            layer.open({
                type:2,
                content:'jsp/resource_upload.jsp',
                area:['500px','300px']
            })
        }

    });
</script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/product_custom.js"></script>
</body>
</html>