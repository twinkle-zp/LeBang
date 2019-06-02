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
<form method="post" enctype="multipart/form-data" id="uploadForm">

    <div class="layui-form-item">
        <label class="layui-form-label">需要人数</label>
        <div class="layui-input-block">
            <input type="text" name="neednum" placeholder="请输入标题" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机号</label>
        <div class="layui-input-block">
            <input type="text" name="phone" placeholder="请输入标题" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">类别</label>
        <div class="layui-input-block">
            <select style="height: 40px;width: 200px" name="type" id="categoryList" onclick="findType()">
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">最早时间</label>
        <div class="layui-input-block">
            <input type="datetime-local" name="start" placeholder="请输入标题" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">最晚时间</label>
        <div class="layui-input-block">
            <input type="datetime-local" name="end" placeholder="请输入标题" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea name="content" placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" onclick="tijiao()">立即提交</button>
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
        findType = function(){
            if($("#categoryList>option").length==0){
                $.ajax({
                    url:"traffic/findType",
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
            }

        }
        tijiao = function () {
            var formData = new FormData($("#uploadForm")[0]);
            var index = parent.layer.getFrameIndex(window.name);//获取当前弹出层的层级
            console.log('123');
            $.ajax({
                async:false,
                type : "post",
                data : formData,
                url : 'traffic/add',
                dataType : 'json',
                contentType: false, //必须
                processData: false, //必须
                success : function(json) {
                    console.log(json);
                    console.log("123123123");
                    if(json.flag==1)
                    {
                        console.log("111");
                        layer.msg('发布成功');
                        window.parent.location.reload();
                        parent.layer.close(index)
                    }
                    else
                    {
                        console.log("123");
                        layer.msg('发布失败');
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
