<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%--解决静态资源路径问题--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>">
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>LeBang</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="css/font.css">
    <link rel="stylesheet" href="css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="js/xadmin.js"></script>
    <script type="text/javascript" src="js/cookie.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="x-nav">
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <input type="text" name="name"  placeholder="请输入商品名" autocomplete="off" class="layui-input">
            <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>

    </xblock>
    <table class="layui-table x-admin">
        <thead>
        <tr>
            <th>ID</th>
            <th>图片</th>
            <th>商品名</th>
            <th>价格</th>
            <th>上架日期</th>
            <th>商品描述</th>
            <th>卖家ID</th>
            <th>卖家</th>
            <th>状态</th>
            <th>操作</th></tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="p">
            <tr>
                <td>${p.id}</td>
                <td><img src="${p.image}"></td>
                <td>${p.name}</td>
                <td>${p.price}</td>
                <td>${p.dateString}</td>
                <td>${p.description}</td>
                <td>${p.userId}</td>
                <td>${p.uname}</td>
                <td class="td-status">
                    <c:if test="${p.flag==0}">
                        <span class="layui-btn layui-btn-normal layui-btn-mini">展示中</span>
                    </c:if>
                    <c:if test="${p.flag==1}">
                        <span class="layui-btn layui-btn-normal layui-btn-mini layui-btn-disabled">未展示</span>
                    </c:if>
                </td>
                <td class="td-manage">
                    <c:if test="${p.flag==0}">
                        <a onclick="member_stop(this,${p.id},${p.flag})" href="javascript:;"  title="禁止">
                            <i class="layui-icon">&#xe62f;</i>
                        </a>
                    </c:if>
                    <c:if test="${p.flag==1}">
                        <a onclick="member_stop(this,${p.id},${p.flag})" href="javascript:;"  title="展示">
                            <i class="layui-icon">&#xe601;</i>
                        </a>
                    </c:if>

                    <a title="编辑"  onclick="x_admin_show('编辑','system/user-edit.jsp?id=${p.id}',600,400)" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" onclick="member_del(this,${p.id})" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="page">
        <div>
            <a class="prev" href="">&lt;&lt;</a>
            <c:forEach begin="1" end="${page.totalPage}" var="currPage">
                <c:if test="${page.currPage == currPage}">
                    <span class="current">${currPage}</span>
                </c:if>
                <c:if test="${page.currPage != currPage}">
                    <a class="num" href="user/findUserList?currPage=${currPage}">${currPage}</a>
                </c:if>
            </c:forEach>
            <a class="next" href="">&gt;&gt;</a>
        </div>
    </div>

</div>
<script>
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

    /*用户-停用*/
    function member_stop(obj,id,flag){
        layer.confirm('确认要修改状态吗？',function(index){
            //发异步把用户状态进行更改
            if($(obj).attr('title')=='禁止'){
                $(obj).attr('title','展示')
                $.ajax({
                    url:"goods/updateFlag?id="+id+"&flag="+flag,
                    type:"post"
                })
                $(obj).find('i').html('&#xe62f;');
                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('未展示');
                layer.msg('已停用!',{icon: 5,time:1000});
            }else{
                $(obj).attr('title','禁止')
                $(obj).find('i').html('&#xe601;');
                $.ajax({
                    url:"goods/updateFlag?id="+id+"&flag="+flag,
                    type:"post"
                })
                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已展示');
                layer.msg('已启用!',{icon: 5,time:1000});
            }
        });
    }

    /*用户-删除*/
    function member_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            //发异步删除数据
            $.ajax({
                url:"goods/deleteByAdmin?id="+id,
                type:"post"
            })
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }



    function delAll (argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？'+data,function(index){
            //捉到所有被选中的，发异步进行删除
            layer.msg('删除成功', {icon: 1});
            $(".layui-form-checked").not('.header').parents('tr').remove();
        });
    }
</script>
<script>var _hmt = _hmt || []; (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

</html>