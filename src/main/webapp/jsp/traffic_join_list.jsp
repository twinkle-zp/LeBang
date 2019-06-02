<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.plat.entity.User" %>
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
    <!-- GLOBAL MANDATORY STYLES -->
    <link href="http://fonts.googleapis.com/css?family=Hind:300,400,500,600,700" rel="stylesheet" type="text/css">

    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

    <!-- THEME STYLES -->
    <%--<link href="css/layout.min.css" rel="stylesheet" type="text/css"/>--%>

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

    <!-- Service -->
    <div id="service" >
        <div class="bg-color-sky-light" data-auto-height="true" >
            <div class="resource_function" style="margin-top:150px;margin-left:400px">
                <button class="layui-btn layui-btn-normal" onclick="add()">发布出行</button>
                <button class="layui-btn layui-btn-normal" onclick="window.location.href='traffic/findMyList'">我发布的</button>
                <button class="layui-btn layui-btn-normal" onclick="window.location.href='traffic/findMyJoin'">我参与的</button>

            </div>
            <div class="content-lg container" style="margin-top: 50px">

                <div class="reviews_container">
                    <ul>
                        <!-- Review -->
                        <c:forEach items="${trafficJoinList}" var="t">
                            <li class=" review clearfix">
                                <div class="review_content">
                                    <div class="review_name">
                                        <a href="javascript:void(0)">已报名：${t.tcontent}&nbsp;&nbsp;
                                            <p style="color: red">[当前状态：<c:if test="${t.flag==0}">未通过</c:if><c:if test="${t.flag!=0}">已通过</c:if>]</p>
                                        </a>

                                    </div>
                                    <div class="review_date">联系方式：${t.phone}
                                    </div>
                                    <div class="review_text">
                                        <p>备注：${t.content}</p>
                                    </div>

                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <!--// end row -->
            </div>
        </div>
    </div>
    <!-- End Service -->


</div>
<script src="layui/layui.js" charset="utf-8"></script>
<script>
    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
        add = function(){
            layer.open({
                type:2,
                content:'traffic_add.jsp',
                area:['500px','300px']
            })
        }
        check = function (id,aid) {
            layer.confirm('是否审核通过', {
                time: 20000, //20s后自动关闭
                btn: ['通过', '不通过', '取消']
                ,btn3: function(index, layero){
                    //按钮【按钮三】的回调
                    console.log("3333")
                    layer.closeAll()
                }
            }, function(index, layero){
                //按钮【按钮一】的回调
                console.log("1111")
                window.location="traffic/check?id="+id+"&flag=1"+"&tafficId="+aid
                //url="avtivity/check?activityJoinId="+id+"&state=1"+"&activityId="+aid
                layer.closeAll()
            }, function(index){
                //按钮【按钮二】的回调
                console.log("2222")
                window.location="traffic/check?id="+id+"&flag=0"+"&tafficId="+aid
            });
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