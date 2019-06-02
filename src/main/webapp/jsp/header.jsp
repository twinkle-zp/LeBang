<%@ page import="com.plat.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: zp
  Date: 2019/4/25
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Header -->

<header class="header" style="background-color: whitesmoke">
    <div class="header_inner d-flex flex-row align-items-center justify-content-start">
        <div class="logo"><a href="#">LeBang</a></div>
        <nav class="main_nav">
            <ul>
                <li><a href="goods/findGoodList">二手交易</a></li>
                <li><a href="traffic/findList">交通互助</a></li>
                <li><a href="activity/findList">活动发布</a></li>
                <li><a href="forum/findList">代办事务</a></li>
                <li><a href="resource/findList">资源共享</a></li>
            </ul>
        </nav>
        <div class="header_content ml-auto">
            <div class="search header_search">
                    <input type="search" class="search_input" required="required" name="searchString" id="search">
                    <button id="search_button" class="search_button" onclick="search()"><img src="images/magnifying-glass.svg" alt=""></button>
            </div>
            <div class="shopping">
                <!-- Cart -->
                <a href="#">
                    <div class="cart">
                        <img src="images/shopping-bag.svg" alt="">
                        <div class="cart_num_container">
                            <div class="cart_num_inner">
                                <div class="cart_num">1</div>
                            </div>
                        </div>
                    </div>
                </a>
                <!-- Star -->
                <a href="#">
                    <div class="star">
                        <img src="images/star.svg" alt="">
                        <div class="star_num_container">
                            <div class="star_num_inner">
                                <div class="star_num">0</div>
                            </div>
                        </div>
                    </div>
                </a>
                <!-- Avatar -->
                <a href="javascript:void(0)" onclick="exit()">
                    <div class="avatar">
                        <img src="images/avatar.svg" alt="">
                    </div>
                </a>
                <a id="username" href="" style="border-bottom: 1px solid cornflowerblue;color: #0e0e0e">
                <%
                    User user = (User)request.getSession().getAttribute("user");
                    String name="未登录";
                    if(user!=null)
                    {
                        name=user.getName();
                    }
                %>
                <%=name%>
            </a>

            </div>
        </div>

        <div class="burger_container d-flex flex-column align-items-center justify-content-around menu_mm"><div></div><div></div><div></div></div>
    </div>
</header>
<script>
    function exit() {
        if(confirm("是否退出当前用户")){
            document.location.href="user/exit";
        }
    }
</script>
