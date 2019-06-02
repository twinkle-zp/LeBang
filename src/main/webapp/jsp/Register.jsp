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
<title>Register</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Wish shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="styles/contact.css">
<link rel="stylesheet" type="text/css" href="styles/contact_responsive.css">
<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
</head>
<script type="application/javascript">
		
		$(function(){
            //给用户名输入框绑定一个失去焦点事件
			$("#username").blur(function () {
				//ajax发送请求,检测当前用户名是否存在
				$.ajax({
					url:"user/checkUsername",
					type:"get",
					data:"username="+$(this).val(),
					success:function (resp) {
						if(resp == '1')
						{
						    //提示不可用
							$("#usernameMsg").css("color","red").html("已经存在");
						}
						else
						{
                            //提示可用
                            $("#usernameMsg").css("color","green").html("恭喜，可用");
						}
                    }
				})
            })
			//给验证码图片绑定一个点击事件
			$("#checkImg").click(function () {
			    //改变一下他本身地址，在url后面加上一个日期
				$(this).attr("src","checkImg/checkImg.jpg?"+new Date());
            })
		})
	</script>

<body>

<div class="super_container">
	
	<!-- Header -->

	<jsp:include page="header.jsp"/>

<!--	 Menu -->

	<div class="menu d-flex flex-column align-items-end justify-content-start text-right menu_mm trans_400">
		<div class="menu_close_container"><div class="menu_close"><div></div><div></div></div></div>
		<div class="logo menu_mm"><a href="#">Wish</a></div>
		<div class="search">
			<form action="#">
				<input type="search" class="search_input menu_mm" required="required">
				<button type="submit" id="search_button" class="search_button menu_mm"><img class="menu_mm" src="images/magnifying-glass.svg" alt=""></button>
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


	
	<!-- Contact Form -->

	<div class="contact">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="review_form_container">
						
						<div class="review_form_content">
							<form action="user/register" method="post" id="review_form" class="review_form">
								<div class="review_form_title">用户注册</div>
								<br />
									<center>	
									<input type="text" name="username" id="username" class="review_form_input" placeholder="用户名" required="required"><span id="usernameMsg"></span>
									<br />
									<br />
									<input type="password" name="password" id="inputPassword" class="review_form_input" placeholder="密码" required="required">
									<br />
									<br />
									<input type="password" id="confirmpwd" class="review_form_input" placeholder="确认密码">
									<br />
									<br />
									<input type="email" name="email" id="inputEmail" class="review_form_input" placeholder="E-mail" required="required">
									<br />
									<br />
									<input type="text" name="name" id="usercaption" class="review_form_input" placeholder="姓名" required="required">
									<br />
									
									<input type="radio" name="sex" id="inlineRadio1" value="男"> 男 &nbsp;&nbsp;&nbsp;
									<input type="radio" name="sex" id="inlineRadio2" value="女"> 女
									<br />
									<br />
									
									<input type="date" class="review_form_input" name="birthday" >
									<br />
									<br />
									<input type="text"  name="yzm" class="review_form_input" placeholder="验证码" required="required">
									<img id="checkImg" src="checkImg/checkImg.jpg"/>
										<p style="color: red">${errorMsg}</p>
									</center>
								<button type="submit" class="review_form_button">注册</button>
							</form>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>




</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<!--<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyCIwF204lFZg1y4kPSIhKaHEXMLYxxuMhA"></script>-->
<script src="js/contact_custom.js"></script>
</body>
</html>