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
    <link rel='stylesheet' id='main-css-css' href='styles/main5152.css?ver=1.0' type='text/css' media='all' />
    <link rel='stylesheet' id='custom-css-css' href='styles/custom5152.html?ver=1.0' type='text/css' media='all' />
    <link rel="stylesheet" type="text/css" href="styles/cart.css">
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

    <div class="forum_function">
        <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i></button>
        <button class="layui-btn layui-btn-primary layui-btn-sm" name="发帖" onclick="javascript:window.location.href='forum_add.html'">
            <i class="layui-icon"></i>
        </button>
        <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i></button>
        <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i></button>
    </div>

    <div class="forum_add">
        <div class="container">
    <div class="row">
        <div class="col">
            <div class="review_form_container">
                <div class="review_form_title">发帖</div>
                <div class="review_form_content">
                    <form action="${pageContext.request.contextPath}/forum/add" id="review_form" class="review_form" method="post" enctype="multipart/form-data">
                        <div class="d-flex flex-md-row flex-column align-items-start justify-content-between">
                            <input type="text" class="review_form_input" placeholder="帖子名称" required="required" name="name">
                            <select class="review_form_input" id="categoryList" name="category"></select>
                            <input type="text" class="review_form_input"  style="visibility: hidden">
                        </div>
                        <textarea class="review_form_text" name="content" placeholder="帖子内容"></textarea></br></br>
                        图片上传：<input type="file" name="img"></br>
                        <button type="submit" class="review_form_button">发布</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
        </div>
    </div>
</div>

<script type='text/javascript' src='js/jquery-1.8.3.min.js'></script>
<script type='text/javascript' src='js/jquery.easing.1.34e44.js?ver=1.3'></script>
<script type='text/javascript' src='js/prettyphoto/jquery.prettyPhotoaeb9.js?ver=3.1.4'></script>
<script type='text/javascript' src='js/jquery.liveSearchd5f7.js?ver=2.0'></script>
<script type='text/javascript' src='js/jflickrfeed.js'></script>
<script type='text/javascript' src='js/jquery.formd471.js?ver=3.18'></script>
<script type='text/javascript' src='js/jquery.validate.minfc6b.js?ver=1.10.0'></script>
<script type='text/javascript' src='js/custom5152.js?ver=1.0'></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/product_custom.js"></script>
</body>
</html>
<script type="application/javascript">
    $.ajax({
        url:"forum/findCategory",
        type:"get",
        dataType:"json",
        success:function (json) {
            //循环遍历json
            for(var i = 0 ;i < json.length;i++)
            {
                var category = json[i];
                //拼装li节点
                var optionNode =  "<option value="+category.id+">"+category.name+"</option>";
                //选中categoryList ，追加liNode
                $("#categoryList").append(optionNode);
            }
        }
    })
</script>