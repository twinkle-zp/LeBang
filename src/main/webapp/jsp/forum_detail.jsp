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

    <!-- Start of Page Container -->
        <div class="container">
            <div class="row">

                <!-- start of page content -->
                <div class="span8 page-content">
                    <article class=" type-post format-standard hentry clearfix">

                        <h1 class="post-title"><a href="#">${article.title}</a></h1>

                        <div class="post-meta clearfix">
                            <span class="date">${article.time}</span>
                            <span class="category"><a href="#" title="View all posts in Server &amp; Database">${article.tname}</a></span>
                            <span class="comments"><a href="#" title="Comment on Integrating WordPress with Your Website">${article.num} Comments</a></span>
                            <span class="like-count">66</span>
                        </div><!-- end of post meta -->

                        <p>${article.content}</p>
                        <c:if test="${article.img!=null}">
                            <a href="#" title="Using Images">
                                <img src="${article.img}" class="attachment-std-thumbnail wp-post-image" >
                            </a>
                        </c:if>
                    </article>

                    <section id="comments">

                        <h3 id="comments-title">(${article.num}) 评论</h3>

                        <ol class="commentlist">
                            <c:forEach items="${commentList}" var="c">
                            <li class="comment even thread-even depth-1" id="li-comment-2">
                                <article id="comment-2">

                                    <a href="#">
                                        <img alt="" src="http://1.gravatar.com/avatar/50a7625001317a58444a20ece817aeca?s=60&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D60&amp;r=G" class="avatar avatar-60 photo" height="60" width="60">
                                    </a>

                                    <div class="comment-meta">

                                        <h5 class="author">
                                            <cite class="fn">
                                                <a href="#" rel="external nofollow" class="url">${c.uname}</a>
                                            </cite>
                                            - <a class="comment-reply-link" href="#">Reply</a>
                                        </h5>

                                        <p class="date">

                                            <time datetime="2013-02-26T13:18:47+00:00">${c.time}</time>

                                        </p>

                                    </div><!-- end .comment-meta -->
                                    <div class="comment-body">
                                        <p>${c.content}</p>
                                    </div><!-- end of comment-body -->
                                    <span class="comments" style="margin-left: 400px">
                                        <a href="javascript:void(0);" onclick="addMulti(${c.id})">回复TA</a>
                                    </span>
                                    <span class="comments" style="margin-left: 20px">
                                        <a href="javascript:void(0);" onclick="findMulti(${c.id})">评论（${c.num}）</a>
                                    </span>
                                </article><!-- end of comment -->

                                <ul class="children" id="children${c.id}">
                                </ul>
                            </li>
                            </c:forEach>
                        </ol>

                        <div id="respond">

                            <h3>  </h3>

                            <div class="cancel-comment-reply">
                                <a rel="nofollow" id="cancel-comment-reply-link" href="#" style="display:none;">Click here to cancel reply.</a>
                            </div>


                            <form action="forum/addComment?id=${article.id}" method="post" id="commentform">


                                <p class="comment-notes"><span class="required"></span></p>


                                <div>
                                    <textarea class="span8" name="content" id="comment" cols="58" rows="10"></textarea>
                                </div>

                                <div>
                                    <input class="btn" name="submit" type="submit" id="submit"  value="Submit Comment">
                                </div>

                            </form>

                        </div>

                    </section><!-- end of comments -->

                </div>
                <!-- end of page content -->
            </div>
        </div>
    <!-- End of Page Container -->


</div>
<script type="application/javascript">

    function findMulti(id)
    {
        if($("#children"+id+">li").length==0)
        {
            //没有li
            $.ajax({
                url:"forum/findMulti?id="+id,
                type:"get",
                dataType:"json",
                success:function (json) {
                    //循环遍历json
                    for(var i = 0 ;i < json.length;i++)
                    {
                        var multi = json[i];
                        //拼装li节点
                        var multiNode = "<li class=\"comment byuser comment-author-saqib-sarwar bypostauthor odd alt depth-2\" id=\"li-comment-3\">\n" +
                            "                                        <article id=\"comment-3\">\n" +
                            "\n" +
                            "                                            <a href=\"#\">\n" +
                            "                                                <img alt=\"\" src=\"http://0.gravatar.com/avatar/2df5eab0988aa5ff219476b1d27df755?s=60&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D60&amp;r=G\" class=\"avatar avatar-60 photo\" height=\"60\" width=\"60\">\n" +
                            "                                            </a>\n" +
                            "\n" +
                            "                                            <div class=\"comment-meta\">\n" +
                            "\n" +
                            "                                                <h5 class=\"author\">\n" +
                            "                                                    <cite class=\"fn\">"+multi.uname+"</cite>\n" +
                            "                                                    - <a class=\"comment-reply-link\" href=\"#\">Reply</a>\n" +
                            "                                                </h5>\n" +
                            "\n" +
                            "                                                <p class=\"date\">\n" +
                            "                                                        <time datetime=\"2013-02-26T13:20:14+00:00\">"+multi.time+"</time>\n" +
                            "                                                </p>\n" +
                            "\n" +
                            "                                            </div><!-- end .comment-meta -->\n" +
                            "\n" +
                            "                                            <div class=\"comment-body\">\n" +
                            "                                                <p>"+multi.content+"</p>\n" +
                            "                                            </div><!-- end of comment-body -->\n" +
                            "\n" +
                            "                                        </article><!-- end of comment -->\n" +
                            "\n" +
                            "                                    </li>"
                        //选中categoryList ，追加liNode
                        $("#children"+id).append(multiNode);
                    }
                }
            })
        }
        else
        {
            $("#children"+id).empty();
        }

    }
</script>
<script src="layui/layui.js" charset="utf-8"></script>
<script>
    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
        addMulti = function(id){
            layer.open({
                type:2,
                content:'jsp/forum_add_multi.jsp?id='+id,
                area:['400px','200px']
            })
        }

    });
</script>
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