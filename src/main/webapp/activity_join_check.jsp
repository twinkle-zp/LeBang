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
    <link rel="stylesheet" href="css/layui.css"  media="all">
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


    <!-- Product -->

    <div class="product">
        <div class="container">
            <div class="row">
                <div class="col">

                </div>
            </div>


            <!-- Reviews -->

            <div class="row">
                <div class="col">
                    <div class="reviews">
                        <div class="current_page">
                            <ul>
                                <li><a href="add_activity.jsp">发起活动</a></li>
                                <li><a href="activity/myJoinActivity">我报名的</a></li>
                                <li><a href="activity/myActivity">我发起的</a></li>
                            </ul>
                        </div><br><br><br>
                        <div class="reviews_title">My Activity</div>

                        <div class="reviews_container">
                            <ul>
                                <!-- Review -->
                                <c:forEach items="${activityJoinList}" var="a">
                                    <li class=" review clearfix">
                                        <a href="join_activity.jsp"><div class="review_image"><img src="images/yibaoming.jpg" /></div></a>
                                        <div class="review_content">
                                            <div class="review_name">
                                                <a href="activity/joinList?activityId=${a.id}">姓名：${a.name}&nbsp;&nbsp;
                                                    [当前状态：<c:if test="${a.state==0}">未通过</c:if><c:if test="${a.state!=0}">已通过</c:if>]
                                                </a>

                                            </div>
                                            <div class="review_date">联系方式：${a.contact}
                                                <button data-method="confirmTrans" class="layui-btn" onclick="check(${a.id},${a.aid})">审核</button>
                                            </div>

                                            <div class="review_text">
                                                <p>备注：${a.content}</p>
                                            </div>

                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <br><br><br><br>
            <div class="row page_num_container">
                <div class="col text-right">
                    <ul class="page_nums">
                        <c:forEach begin="1" end="${page.totalPage}" var="currPage">
                            <li <c:if test="${page.currPage == currPage}">class="active"</c:if> > <a href="#">${currPage}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>


        </div>
    </div>


</div>
<script src="layui/layui.js" charset="utf-8"></script>
<script>

    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句

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
                window.location="activity/check?activityJoinId="+id+"&state=1"+"&activityId="+aid
                //url="avtivity/check?activityJoinId="+id+"&state=1"+"&activityId="+aid
                layer.closeAll()
            }, function(index){
                //按钮【按钮二】的回调
                console.log("2222")
                window.location="activity/check?activityJoinId="+id+"&state=0"+"&activityId="+aid
            });
        }
        //触发事件
        // var active = {
        //     setTop: function(){
        //         var that = this;
        //         //多窗口模式，层叠置顶
        //         layer.open({
        //             type: 2 //此处以iframe举例
        //             ,title: '当你选择该窗体时，即会在最顶端'
        //             ,area: ['390px', '260px']
        //             ,shade: 0
        //             ,maxmin: true
        //             ,offset: [ //为了演示，随机坐标
        //                 Math.random()*($(window).height()-300)
        //                 ,Math.random()*($(window).width()-390)
        //             ]
        //             ,content: '//layer.layui.com/test/settop.html'
        //             ,btn: ['继续弹出', '全部关闭'] //只是为了演示
        //             ,yes: function(){
        //                 $(that).click();
        //             }
        //             ,btn2: function(){
        //                 layer.closeAll();
        //             }
        //
        //             ,zIndex: layer.zIndex //重点1
        //             ,success: function(layero){
        //                 layer.setTop(layero); //重点2
        //             }
        //         });
        //     }
        //     ,confirmTrans: function(){
        //         //配置一个透明的询问框
        //         console.log("sssssssssssssssssssssss");
        //         layer.msg('大部分参数都是可以公用的<br>合理搭配，展示不一样的风格', {
        //             time: 20000, //20s后自动关闭
        //             btn: ['明白了', '知道了', '哦']
        //         });
        //     }
        //     ,notice: function(){
        //         //示范一个公告层
        //         layer.open({
        //             type: 1
        //             ,title: false //不显示标题栏
        //             ,closeBtn: false
        //             ,area: '300px;'
        //             ,shade: 0.8
        //             ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
        //             ,btn: ['火速围观', '残忍拒绝']
        //             ,btnAlign: 'c'
        //             ,moveType: 1 //拖拽模式，0或者1
        //             ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">你知道吗？亲！<br>layer ≠ layui<br><br>layer只是作为Layui的一个弹层模块，由于其用户基数较大，所以常常会有人以为layui是layerui<br><br>layer虽然已被 Layui 收编为内置的弹层模块，但仍然会作为一个独立组件全力维护、升级。<br><br>我们此后的征途是星辰大海 ^_^</div>'
        //             ,success: function(layero){
        //                 var btn = layero.find('.layui-layer-btn');
        //                 btn.find('.layui-layer-btn0').attr({
        //                     href: 'http://www.layui.com/'
        //                     ,target: '_blank'
        //                 });
        //             }
        //         });
        //     }
        //     ,offset: function(othis){
        //         var type = othis.data('type')
        //             ,text = othis.text();
        //
        //         layer.open({
        //             type: 1
        //             ,offset: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
        //             ,id: 'layerDemo'+type //防止重复弹出
        //             ,content: '<div style="padding: 20px 100px;">'+ text +'</div>'
        //             ,btn: '关闭全部'
        //             ,btnAlign: 'c' //按钮居中
        //             ,shade: 0 //不显示遮罩
        //             ,yes: function(){
        //                 layer.closeAll();
        //             }
        //         });
        //     }
        // };

        $('#layerDemo .layui-btn').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

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