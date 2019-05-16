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
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
    <link rel='stylesheet' id='main-css-css'  href='styles/main5152.css?ver=1.0' type='text/css' media='all' />
    <link rel='stylesheet' id='custom-css-css'  href='styles/custom5152.html?ver=1.0' type='text/css' media='all' />
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
    <!-- Start of Page Container -->

        <div class="container">
            <div class="row">

                <!-- start of page content -->
                <div class="span8 main-listing">
                    <c:forEach items="${page.list}" var="p">
                    <article class="format-standard type-post hentry clearfix">

                        <header class="clearfix">

                            <h3 class="post-title">
                                <a href="forum/findDetail?id=${p.id}">${p.title}</a>
                            </h3>

                            <div class="post-meta clearfix">
                                <span class="date">${p.time}</span>
                                <span class="category"><a href="#" title="View all posts in Server &amp; Database">${p.tname}</a></span>
                                <span class="comments"><a href="#" title="Comment on Integrating WordPress with Your Website">${p.num}</a></span>
                                <span class="like-count">66</span>
                            </div><!-- end of post meta -->

                        </header>
                        <c:if test="${p.img!=null}">
                            <a href="#" title="Using Images">
                                <img src="${p.img}" class="attachment-std-thumbnail wp-post-image" >
                            </a>
                        </c:if>
                        <p>${p.content}<a class="readmore-link" href="http://knowledgebase.inspirythemes.com/integrating-wordpress-with-your-website/">Read more</a></p>

                    </article>
                    </br>
                    </c:forEach>


                    <div id="pagination">
                        <c:forEach begin="1" end="${page.totalPage}" var="currPage">
                            <a href="#" <c:if test="${page.currPage == currPage}">class="btn active"</c:if> >${currPage}</a>
                        </c:forEach>
                    </div>

                </div>
                <!-- end of page content -->
            </div>
        </div>
    <!-- End of Page Container -->


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