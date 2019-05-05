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
								<li><a href="categories.html">Woman's Fashion</a></li>
								<li><a href="categories.html">Swimsuits</a></li>
								<li>2 Piece Swimsuits</li>
							</ul>
						</div><br><br><br>
						<div class="reviews_title">reviews</div>
						<div class="reviews_container">
							<ul>
								<!-- Review -->
								<c:forEach items="${message}" var="m">
								<li class=" review clearfix">
									<div class="review_image">
										<c:if test="${m.fromId==userId}"><img src="images/me.jpg" alt=""></c:if>
										<c:if test="${m.fromId!=userId}"><img src="images/you.jpg" alt=""></c:if>
									</div>
									<div class="review_content">
										<div class="review_name">${m.fromName}</div>
										<div class="review_date">${m.date}</div>
										<div class="review_text">
											<p>${m.content}</p>
										</div>
									</div>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- Leave a Review -->

			<div class="row">
				<div class="col">
					<div class="review_form_container">
						<div class="review_form_content">
							<form action="#" id="review_form" class="review_form">
								<textarea class="review_form_text" name="review_form_text" placeholder="Message"></textarea>
								<button type="submit" class="review_form_button">leave a review</button>
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
<script src="js/product_custom.js"></script>
</body>
</html>