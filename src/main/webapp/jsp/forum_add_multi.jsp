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
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>
<form class="layui-form" method="post" enctype="multipart/form-data" id="uploadForm">
    <%
        String comId=request.getParameter("id");
    %>
    <input type="hidden" name="comId" value="<%=comId%>">
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">回复内容</label>
        <div class="layui-input-block">
            <textarea name="content" placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" onclick="tijiao()">回复</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            <button class="layui-btn" onclick="closeThis()">取消</button>
        </div>
    </div>
</form>
<script src="layui/layui.js" charset="utf-8"></script>

</body>
</html>
<script>
    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
        closeThis = function(){
            console.log("123");
            var index = parent.layer.getFrameIndex(window.name);//获取当前弹出层的层级

            window.parent.location.reload();
            parent.layer.close(index)
        }
        tijiao = function () {
            var formData = new FormData($("#uploadForm")[0]);
            var index = parent.layer.getFrameIndex(window.name);//获取当前弹出层的层级
            console.log('123');
            $.ajax({
                async:false,
                type : "post",
                data : formData,
                url : 'forum/addMulti',
                dataType : 'json',
                contentType: false, //必须
                processData: false, //必须
                success : function(json) {
                    console.log(json);
                    console.log("123123123");
                    if(json.flag=="1")
                    {
                        console.log("111");
                        layer.msg('回复成功');
                        window.parent.location.reload();
                        parent.layer.close(index)
                    }
                    else
                    {
                        console.log("123");
                        layer.msg('回复失败');
                    }
                },
                error:function (json) {
                    console.log("error111");
                    console.log(json);
                    if(json=="1")
                    {
                        console.log("111");
                        layer.msg('上传成功');
                        window.parent.location.reload();
                        parent.layer.close(index)
                    }
                    else
                    {
                        console.log("123");
                        layer.msg('上传失败');
                    }
                }
            })
        }

    });
</script>