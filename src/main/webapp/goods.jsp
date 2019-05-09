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
<title>Categories</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Wish shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="plugins/malihu-custom-scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="styles/categories.css">
<link rel="stylesheet" type="text/css" href="styles/categories_responsive.css">
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
				<li class="menu_mm"><a href="#">home</a></li>
				<li class="menu_mm"><a href="#">clothes</a></li>
				<li class="menu_mm"><a href="#">accessories</a></li>
				<li class="menu_mm"><a href="#">lingerie</a></li>
				<li class="menu_mm"><a href="#">contact</a></li>
			</ul>
		</nav>
	</div>


	<!-- Products -->

	<div class="products">
		<div class="container">
			<div class="row">
				<div class="col-12">
					
					<!-- Sidebar Left -->

					<div class="sidebar_left clearfix">

						<!-- Size -->
						<div class="sidebar_section sidebar_options">
							<div class="sidebar_section_content">

								<!-- Option Item -->
								<div class="sidebar_option d-flex flex-row align-items-center justify-content-start">
									<div class="option_image"><img src="images/option_1.png" alt=""></div>
									<a href="goods/findGoodList">
									<div class="option_content">
										<div class="option_title">全部商品</div>
										<div class="option_subtitle">all goods</div>
									</div>
									</a>
								</div>

								<!-- Option Item -->

								<div class="sidebar_option d-flex flex-row align-items-center justify-content-start">
									<div class="option_image"><img src="images/option_2.png" alt=""></div>
									<a href="goods/myGoods">
										<div class="option_content">
										<div class="option_title">我的商品</div>
										<div class="option_subtitle">my goods</div>
										</div>
									</a>
								</div>

								<!-- Option Item -->
								<div class="sidebar_option d-flex flex-row align-items-center justify-content-start">
									<div class="option_image"><img src="images/option_3.png" alt=""></div>
                                    <a href="addgoods.jsp">
									<div class="option_content">
										<div class="option_title">上架商品</div>
										<div class="option_subtitle">add goods</div>
									</div>
                                    </a>
								</div>

								<!-- Option Item -->
								<div class="sidebar_option d-flex flex-row align-items-center justify-content-start">
									<div class="option_image"><img src="images/option_4.png" alt=""></div>
									<a href="goods/myMessage">
									<div class="option_content">
										<div class="option_title">我的留言</div>
										<div class="option_subtitle">my message</div>
									</div>
									</a>
								</div>

							</div>
						</div>
						<!-- Categories -->
						<div class="sidebar_section">
							<div class="sidebar_title">Categories</div>
							<div class="sidebar_section_content">
								<ul>
									<li><a href="#">Wedding Dresses (23)</a></li>
									<li><a href="#">Swimsuits (11)</a></li>
									<li><a href="#">Jeans (61)</a></li>
									<li><a href="#">Tops (34)</a></li>
								</ul>
							</div>
						</div>
	

						<!-- Price -->
						<div class="sidebar_section">
							<div class="sidebar_title">Price</div>
							<div class="sidebar_section_content">
								<div class="filter_price">
									<div id="slider-range" class="slider_range"></div>
									<p><input type="text" id="amount" class="amount" readonly style="border:0; font-weight:bold;"></p>
									<div class="clear_price_btn">Clear Price</div>
								</div>
							</div>
						</div>

						<!-- Best Sellers -->

						<div class="sidebar_section">
							<div class="sidebar_title">Best Sellers</div>
							<div class="sidebar_section_content bestsellers_content">
								<ul>
									<!-- Best Seller Item -->
									<li class="clearfix">
										<div class="best_image"><img src="images/best_1.jpg" alt=""></div>
										<div class="best_content">
											<div class="best_title"><a href="goods_info.jsp">Blue dress with dots</a></div>
											<div class="best_price">$45</div>
										</div>
										<div class="best_buy">+</div>
									</li>

									<!-- Best Seller Item -->
									<li class="clearfix">
										<div class="best_image"><img src="images/best_2.jpg" alt=""></div>
										<div class="best_content">
											<div class="best_title"><a href="goods_info.jsp">White t-shirt</a></div>
											<div class="best_price">$45</div>
										</div>
										<div class="best_buy">+</div>
									</li>

									<!-- Best Seller Item -->
									<li class="clearfix">
										<div class="best_image"><img src="images/best_3.jpg" alt=""></div>
										<div class="best_content">
											<div class="best_title"><a href="goods_info.jsp">Blue dress with dots</a></div>
											<div class="best_price">$45</div>
										</div>
										<div class="best_buy">+</div>
									</li>

									<!-- Best Seller Item -->
									<li class="clearfix">
										<div class="best_image"><img src="images/best_4.jpg" alt=""></div>
										<div class="best_content">
											<div class="best_title"><a href="goods_info.jsp">White t-shirt</a></div>
											<div class="best_price">$45</div>
										</div>
										<div class="best_buy">+</div>
									</li>

								</ul>
							</div>
						</div>



					</div>

					<div class="current_page">Woman's Fashion</div>
				</div>
				<div class="col-12">
					<div class="product_sorting clearfix">
						<div class="view">
							<div class="view_box box_view"><i class="fa fa-th-large" aria-hidden="true"></i></div>
							<div class="view_box detail_view"><i class="fa fa-bars" aria-hidden="true"></i></div>
						</div>
						<div class="sorting">
							<ul class="item_sorting">
								<li>
									<span class="sorting_text">Show all</span>
									<i class="fa fa-caret-down" aria-hidden="true"></i>
									<ul>
										<li class="product_sorting_btn" data-isotope-option='{ "sortBy": "original-order" }'><span>Show All</span></li>
										<li class="product_sorting_btn" data-isotope-option='{ "sortBy": "price" }'><span>Price</span></li>
										<li class="product_sorting_btn" data-isotope-option='{ "sortBy": "stars" }'><span>Stars</span></li>
									</ul>
								</li>
								<li>
									<span class="sorting_text">Show</span>
									<span class="num_sorting_text">12</span>
									<i class="fa fa-caret-down" aria-hidden="true"></i>
									<ul>
										<li class="num_sorting_btn"><span>3</span></li>
										<li class="num_sorting_btn"><span>6</span></li>
										<li class="num_sorting_btn"><span>12</span></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class="row products_container">
				<div class="col">
					
					<!-- Products -->

					<div class="product_grid">

						<!-- Product -->
						<c:forEach items="${page.list}" var="p">
						<div class="product">
							<div class="product_image"><img src="${p.image}" alt=""></div>
							<div class="rating rating_4" data-rating="4">
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
								<i class="fa fa-star"></i>
							</div>
							<div class="product_content clearfix">
								<div class="product_info">
									<div class="product_name"><a href="goods/findGoodsById?id=${p.id}">${p.name}</a></div>
									<div class="product_price">￥${p.price}</div>
								</div>
								<div class="product_options">
									<div class="product_buy product_option"><img src="images/shopping-bag-white.svg" alt=""></div>

									<c:if test="${userId==p.userId}"><a onclick="deleteGood(${p.id})"><div class="product_fav product_option">×</div></a></c:if>
									<c:if test="${userId!=p.userId}"><div class="product_fav product_option">+</div></c:if>
								</div>
							</div>
						</div>
						</c:forEach>
					</div>
				</div>
					
			</div>

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
		
		<!-- Sidebar Right -->

		<div class="sidebar_right clearfix">

			<!-- Promo 1 -->
			<div class="sidebar_promo_1 sidebar_promo d-flex flex-column align-items-center justify-content-center">
				<div class="sidebar_promo_image" style="background-image: url(images/sidebar_promo_1.jpg)"></div>
				<div class="sidebar_promo_content text-center">
					<div class="sidebar_promo_title">30%<span>off</span></div>
					<div class="sidebar_promo_subtitle">On all shoes</div>
					<div class="sidebar_promo_button"><a href="login.jsp">check out</a></div>
				</div>
			</div>

			<!-- Promo 2 -->
			<div class="sidebar_promo_2 sidebar_promo">
				<div class="sidebar_promo_image" style="background-image: url(images/sidebar_promo_2.jpg)"></div>
				<div class="sidebar_promo_content text-center">
					<div class="sidebar_promo_title">30%<span>off</span></div>
					<div class="sidebar_promo_subtitle">On all shoes</div>
					<div class="sidebar_promo_button"><a href="login.jsp">check out</a></div>
				</div>
			</div>
		</div>

	</div>

	<!-- Extra -->

	

</div>

<script>
	function deleteGood(id) {
		if(confirm("是否下架该商品")){
			document.location.href="goods/delete?id="+id;
		}
	}
</script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="plugins/malihu-custom-scrollbar/jquery.mCustomScrollbar.js"></script>
<script src="plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="js/categories_custom.js"></script>
</body>
</html>