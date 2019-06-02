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
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">演示</a>
        <a>
          <cite>导航元素</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
      <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
          <input type="text" name="username"  placeholder="请输入用户名" autocomplete="off" class="layui-input">
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
      </div>
      <xblock>
        <button class="layui-btn" onclick="x_admin_show('添加用户','./member-add.html',600,400)"><i class="layui-icon"></i>添加</button>
      </xblock>
      <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>ID</th>
            <th>用户名</th>
            <th>密码</th>
            <th>手机</th>
            <th>邮箱</th>
            <th>姓名</th>
            <th>性别</th>
            <th>状态</th>
            <th>操作</th></tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="p">
          <tr>
            <td>${p.uid}</td>
            <td>${p.username}</td>
            <td>${p.password}</td>
            <td>${p.telephone}</td>
            <td>${p.email}</td>
              <td>${p.name}</td>
            <td>${p.sex}</td>
            <td class="td-status">
                <c:if test="${p.state==0}">
                    <span class="layui-btn layui-btn-normal layui-btn-mini">已启用</span>
                </c:if>
                <c:if test="${p.state==1}">
                    <span class="layui-btn layui-btn-normal layui-btn-mini layui-btn-disabled">已停用</span>
                </c:if>
            </td>
            <td class="td-manage">
              <c:if test="${p.state==0}">
                <a onclick="member_stop(this,${p.uid},${p.state})" href="javascript:;"  title="停用">
                  <i class="layui-icon">&#xe62f;</i>
                </a>
              </c:if>
              <c:if test="${p.state==1}">
                <a onclick="member_stop(this,${p.uid},${p.state})" href="javascript:;"  title="启用">
                  <i class="layui-icon">&#xe601;</i>
                </a>
              </c:if>

              <a title="编辑"  onclick="x_admin_show('编辑','system/user-edit.jsp?uid=${p.uid}',600,400)" href="javascript:;">
                <i class="layui-icon">&#xe642;</i>
              </a>
              <a title="删除" onclick="member_del(this,${p.uid})" href="javascript:;">
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
      function member_stop(obj,id,state){
          layer.confirm('确认要停用吗？',function(index){
            //发异步把用户状态进行更改
                if($(obj).attr('title')=='停用'){
                  $(obj).attr('title','启用')
                  $.ajax({
                    url:"user/updateState?uid="+id+"&state="+state,
                    type:"post"
                  })
                  $(obj).find('i').html('&#xe62f;');
                  $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                  layer.msg('已停用!',{icon: 5,time:1000});
                }else{
                  $(obj).attr('title','停用')
                  $(obj).find('i').html('&#xe601;');
                  $.ajax({
                    url:"user/updateState?uid="+id+"&state="+state,
                    type:"post"
                  })
                  $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                  layer.msg('已启用!',{icon: 5,time:1000});
                }
              });
      }

      /*用户-删除*/
      function member_del(obj,id){
          layer.confirm('确认要删除吗？',function(index){
              //发异步删除数据
            $.ajax({
              url:"user/delete?uid="+id,
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