<%@page import="fabric.DAO.hideString"%>
<%@page import="fabric.DAO.categoryDAO"%>
<%@page import="entities.categories"%>
<%@page import="entities.products"%>
<%@page import="java.util.List"%>
<%@page import="fabric.DAO.factoryDAO"%>
<%@page import="fabric.DAO.productDAO"%>
<%@page import="entities.Users"%>

<%
// Debugging session and user role
System.out.println("Session ID: " + session.getId());
Users user1 = (Users) session.getAttribute("current-user");
if (user1 == null) {
	session.setAttribute("message", "You are not logged In!");
	response.sendRedirect("index.jsp");
	return;
} else {
	if (user1.getUserRole().equals("customer")) {
		response.sendRedirect("AfterLogin.jsp");
		return;
	}
	System.out.println("Logged-in user: " + user1.getUserName());
	System.out.println("User role: " + user1.getUserRole());

	Cookie[] cookies = request.getCookies();
	boolean f = false;
	String email = "";
	if (cookies == null) {
		out.print("you are not login first login your account");
	} else {
		for (Cookie c : cookies) {
	String temp = c.getName();
	if (temp.equals("user_id")) {
		f = true;
		email = c.getValue();
	}
		}
	}
}
%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fabric Fusion - eCommerce Website</title>

<!--
    - favicon
  -->
<link rel="shortcut icon" href="./static/images/logo/favicon.ico"
	type="image/x-icon">

<!--
    - custom css link
  -->
 <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./static/css/style-prefix.css">

<!--
    - google font link
  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">

</head>

<body>


	<div class="overlay" data-overlay></div>

	<!--
    - MODAL
  

  <div class="modal" data-modal>

    <div class="modal-close-overlay" data-modal-overlay></div>

    <div class="modal-content">

      <button class="modal-close-btn" data-modal-close>
        <ion-icon name="close-outline"></ion-icon>
      </button>

      <div class="newsletter-img">
        <img src="./static/images/newsletter.png" alt="subscribe newsletter" width="400" height="400">
      </div>

      <div class="newsletter">

        <form action="#">

          <div class="newsletter-header">

            <h3 class="newsletter-title">Subscribe Newsletter.</h3>

            <p class="newsletter-desc">
              Subscribe the <b>Anon</b> to get latest products and discount update.
            </p>

          </div>

          <input type="email" name="email" class="email-field" placeholder="Email Address" required>

          <button type="submit" class="btn-newsletter">Subscribe</button>

        </form>

      </div>

    </div>

  </div>


-->


	<!--
    - NOTIFICATION TOAST
  -->

	<div class="notification-toast" data-toast>

		<button class="toast-close-btn" data-toast-close>
			<ion-icon name="close-outline"></ion-icon>
		</button>

		<div class="toast-banner">
			<img src="./static/images/products/jewellery-1.jpg"
				alt="Rose Gold Earrings" width="80" height="70">
		</div>

		<div class="toast-detail">

			<p class="toast-message">Someone in new just bought</p>

			<p class="toast-title">Rose Gold Earrings</p>

			<p class="toast-meta">
				<time datetime="PT2M">2 Minutes</time>
				ago
			</p>

		</div>

	</div>





	<!--
    - HEADER
  -->

	<header>

		<div class="header-top">

			<div class="container">

				<ul class="header-social-container">

					<li><a href="#" class="social-link"> <ion-icon
								name="logo-facebook"></ion-icon>
					</a></li>

					<li><a href="#" class="social-link"> <ion-icon
								name="logo-twitter"></ion-icon>
					</a></li>

					<li><a href="#" class="social-link"> <ion-icon
								name="logo-instagram"></ion-icon>
					</a></li>

					<li><a href="#" class="social-link"> <ion-icon
								name="logo-linkedin"></ion-icon>
					</a></li>

				</ul>

				<div class="header-alert-news">
					<p>
						<b>Free Shipping</b> This Week Order Over - 500/-
					</p>
				</div>

				<div class="header-top-actions">

					<!--   <select name="currency">

            <option value="usd">USD &dollar;</option>
            <option value="eur">EUR &euro;</option>

          </select>

          <select name="language">

            <option value="en-US">English</option>
            <option value="es-ES">Espa&ntilde;ol</option>
            <option value="fr">Fran&ccedil;ais</option>

          </select>
-->

					<%
					productDAO dao = new productDAO(factoryDAO.getFactory());
					List<products> list = dao.getAllProducts();

					categoryDAO cdao = new categoryDAO(factoryDAO.getFactory());
					List<categories> clist = cdao.getcategories();
					%>

					<p>
						products Available<%=list.size()%></p>


				</div>

			</div>

		</div>

		<div class="header-main">

			<div class="container">

				<a href="#" class="header-logo"> <img
					src="./static/images/logo/logo.svg" alt="FabricFusion's logo"
					width="120" height="36">
				</a>

				<div class="header-search-container">

					<input type="search" name="search" class="search-field"
						placeholder="Enter your product name...">

					<button class="search-btn">
						<ion-icon name="search-outline"></ion-icon>
					</button>

				</div>

				<div class="header-user-actions">

					<%
					if (user1 == null) {
					%>
					<!-- Login Button -->
					<a href="login.jsp" class="action-btn" id="loginButton"> <ion-icon
							name="person-outline"></ion-icon> <span>Login</span>
					</a>
					<%
					} else {
					%>
					<!-- Logout Button -->
					<a href="logoutServlet" class="action-btn" id="logoutButton"> <ion-icon
							name="log-out-outline"></ion-icon> <span>Logout</span>
					</a>
					<%
					}
					%>

					<button class="action-btn">
						<ion-icon name="heart-outline"></ion-icon>
						<span class="count">0</span>
					</button>

					<button class="action-btn">
						<a href="AddToCart.jsp"><ion-icon name="bag-handle-outline"></ion-icon></a>
						<span class="count cart-item">0</span>
					</button>

				</div>

			</div>

		</div>

		<nav class="desktop-navigation-menu">

			<div class="container">

				<ul class="desktop-menu-category-list">

					<li class="menu-category"><a href="#" class="menu-title">Home</a>
					</li>

					<li class="menu-category"><a href="#" class="menu-title">Categories</a>

						<div class="dropdown-panel">

							<%
							for (categories cate : clist) {
							%>

							<ul class="dropdown-panel-list">

								<li class="menu-title"><a href="#"><%=cate.getCategoryName()%></a>
								</li>

								<li class="panel-list-item"><a href="#">Desktop</a></li>

								<li class="panel-list-item"><a href="#">Laptop</a></li>

								<li class="panel-list-item"><a href="#">Camera</a></li>

								<li class="panel-list-item"><a href="#">Tablet</a></li>

								<li class="panel-list-item"><a href="#">Headphone</a></li>

								<li class="panel-list-item"><a href="#"> <img
										src="./static/images/electronics-banner-1.jpg"
										alt="headphone collection" width="250" height="119">
								</a></li>

							</ul>
							<%
							}
							%>
						</li>

					<li class="menu-category"><a href="#" class="menu-title">Women's</a>

						<ul class="dropdown-list">

							<li class="dropdown-item"><a href="#">Dress & Frock</a></li>

							<li class="dropdown-item"><a href="#">Earrings</a></li>

							<li class="dropdown-item"><a href="#">Necklace</a></li>

							<li class="dropdown-item"><a href="#">Makeup Kit</a></li>

						</ul></li>

					<li class="menu-category"><a href="#" class="menu-title">Jewelry</a>

						<ul class="dropdown-list">

							<li class="dropdown-item"><a href="#">Earrings</a></li>

							<li class="dropdown-item"><a href="#">Couple Rings</a></li>

							<li class="dropdown-item"><a href="#">Necklace</a></li>

							<li class="dropdown-item"><a href="#">Bracelets</a></li>

						</ul></li>

					<li class="menu-category"><a href="#" class="menu-title">Perfume</a>

						<ul class="dropdown-list">

							<li class="dropdown-item"><a href="#">Clothes Perfume</a></li>

							<li class="dropdown-item"><a href="#">Deodorant</a></li>

							<li class="dropdown-item"><a href="#">Flower Fragrance</a></li>

							<li class="dropdown-item"><a href="#">Air Freshener</a></li>

						</ul></li>

					<li class="menu-category"><a href="#" class="menu-title">Blog</a>
					</li>

					<li class="menu-category"><a href="#" class="menu-title">Hot
							Offers</a></li>

				</ul>

			</div>

		</nav>

		<div class="mobile-bottom-navigation">

			<button class="action-btn" data-mobile-menu-open-btn>
				<ion-icon name="menu-outline"></ion-icon>
			</button>

			<button class="action-btn">
				<a href="AddToCart.jsp"><ion-icon name="bag-handle-outline"></ion-icon></a>
				<span class="count cart-item">0</span>
			</button>

			<button class="action-btn">
				<a href="AfterLogin.jsp"><ion-icon name="home-outline"></ion-icon></a>
			</button>

			<button class="action-btn">
				<ion-icon name="heart-outline"></ion-icon>

				<span class="count">0</span>
			</button>

			<button class="action-btn" data-mobile-menu-open-btn>
				<ion-icon name="grid-outline"></ion-icon>
			</button>

		</div>

		<nav class="mobile-navigation-menu  has-scrollbar" data-mobile-menu>

			<div class="menu-top">
				<h2 class="menu-title">Menu</h2>

				<button class="menu-close-btn" data-mobile-menu-close-btn>
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>

			<ul class="mobile-menu-category-list">

				<li class="menu-category"><a href="#" class="menu-title">Home</a>
				</li>

				<li class="menu-category">

					<button class="accordion-menu" data-accordion-btn>
						<p class="menu-title">Men's</p>

						<div>
							<ion-icon name="add-outline" class="add-icon"></ion-icon>
							<ion-icon name="remove-outline" class="remove-icon"></ion-icon>
						</div>
					</button>

					<ul class="submenu-category-list" data-accordion>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Shirt</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Shorts & Jeans</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Safety Shoes</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Wallet</a></li>

					</ul>

				</li>

				<li class="menu-category">

					<button class="accordion-menu" data-accordion-btn>
						<p class="menu-title">Women's</p>

						<div>
							<ion-icon name="add-outline" class="add-icon"></ion-icon>
							<ion-icon name="remove-outline" class="remove-icon"></ion-icon>
						</div>
					</button>

					<ul class="submenu-category-list" data-accordion>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Dress & Frock</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Earrings</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Necklace</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Makeup Kit</a></li>

					</ul>

				</li>

				<li class="menu-category">

					<button class="accordion-menu" data-accordion-btn>
						<p class="menu-title">Jewelry</p>

						<div>
							<ion-icon name="add-outline" class="add-icon"></ion-icon>
							<ion-icon name="remove-outline" class="remove-icon"></ion-icon>
						</div>
					</button>

					<ul class="submenu-category-list" data-accordion>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Earrings</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Couple Rings</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Necklace</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Bracelets</a></li>

					</ul>

				</li>

				<li class="menu-category">

					<button class="accordion-menu" data-accordion-btn>
						<p class="menu-title">Perfume</p>

						<div>
							<ion-icon name="add-outline" class="add-icon"></ion-icon>
							<ion-icon name="remove-outline" class="remove-icon"></ion-icon>
						</div>
					</button>

					<ul class="submenu-category-list" data-accordion>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Clothes Perfume</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Deodorant</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Flower Fragrance</a></li>

						<li class="submenu-category"><a href="#"
							class="submenu-title">Air Freshener</a></li>

					</ul>

				</li>

				<li class="menu-category"><a href="#" class="menu-title">Blog</a>
				</li>

				<li class="menu-category"><a href="#" class="menu-title">Hot
						Offers</a></li>

			</ul>

			<div class="menu-bottom">

				<ul class="menu-category-list">

					<li class="menu-category">

						<button class="accordion-menu" data-accordion-btn>
							<p class="menu-title">Language</p>

							<ion-icon name="caret-back-outline" class="caret-back"></ion-icon>
						</button>

						<ul class="submenu-category-list" data-accordion>

							<li class="submenu-category"><a href="#"
								class="submenu-title">English</a></li>

							<li class="submenu-category"><a href="#"
								class="submenu-title">Espa&ntilde;ol</a></li>

							<li class="submenu-category"><a href="#"
								class="submenu-title">Fren&ccedil;h</a></li>

						</ul>

					</li>

					<li class="menu-category">
						<button class="accordion-menu" data-accordion-btn>
							<p class="menu-title">Currency</p>
							<ion-icon name="caret-back-outline" class="caret-back"></ion-icon>
						</button>

						<ul class="submenu-category-list" data-accordion>
							<li class="submenu-category"><a href="#"
								class="submenu-title">USD &dollar;</a></li>

							<li class="submenu-category"><a href="#"
								class="submenu-title">EUR &euro;</a></li>
						</ul>
					</li>

				</ul>

				<ul class="menu-social-container">

					<li><a href="#" class="social-link"> <ion-icon
								name="logo-facebook"></ion-icon>
					</a></li>

					<li><a href="#" class="social-link"> <ion-icon
								name="logo-twitter"></ion-icon>
					</a></li>

					<li><a href="#" class="social-link"> <ion-icon
								name="logo-instagram"></ion-icon>
					</a></li>

					<li><a href="#" class="social-link"> <ion-icon
								name="logo-linkedin"></ion-icon>
					</a></li>

				</ul>

			</div>

		</nav>

	</header>





	<!--
    - MAIN
  -->

	<main>

		<!--
      - BANNER
    -->

		<div class="banner">

			<div class="container">

				<div class="slider-container has-scrollbar">

					<div class="slider-item">

						<img src="./static/images/banner-1.jpg"
							alt="women's latest fashion sale" class="banner-img">

						<div class="banner-content">

							<p class="banner-subtitle">Trending item</p>

							<h2 class="banner-title">Women's latest fashion sale</h2>

							<p class="banner-text">
								starting at &dollar; <b>20</b>.00
							</p>

							<a href="#" class="banner-btn">Shop now</a>

						</div>

					</div>

					<div class="slider-item">

						<img src="./static/images/banner-2.jpg" alt="modern sunglasses"
							class="banner-img">

						<div class="banner-content">

							<p class="banner-subtitle">Trending accessories</p>

							<h2 class="banner-title">Modern sunglasses</h2>

							<p class="banner-text">
								starting at &dollar; <b>15</b>.00
							</p>

							<a href="#" class="banner-btn">Shop now</a>

						</div>

					</div>

					<div class="slider-item">

						<img src="./static/images/banner-3.jpg"
							alt="new fashion summer sale" class="banner-img">

						<div class="banner-content">

							<p class="banner-subtitle">Sale Offer</p>

							<h2 class="banner-title">New fashion summer sale</h2>

							<p class="banner-text">
								starting at &dollar; <b>29</b>.99
							</p>

							<a href="#" class="banner-btn">Shop now</a>

						</div>

					</div>

				</div>

			</div>

		</div>





		<!--
      - CATEGORY
    -->

		<div class="category">

			<div class="container">

				<div class="category-item-container has-scrollbar">

					<div class="category-item">

						<div class="category-img-box">
							<img src="./static/images/icons/dress.svg" alt="dress & frock"
								width="30">
						</div>

						<div class="category-content-box">

							<div class="category-content-flex">
								<h3 class="category-item-title">Ethnic Dress</h3>

								<p class="category-item-amount">(53)</p>
							</div>

							<a href="productList.jsp" class="category-btn">Show all</a>

						</div>

					</div>

					<div class="category-item">

						<div class="category-img-box">
							<img src="./static/images/icons/coat.svg" alt="winter wear"
								width="30">
						</div>

						<div class="category-content-box">

							<div class="category-content-flex">
								<h3 class="category-item-title">Winter wear</h3>

								<p class="category-item-amount">(58)</p>
							</div>

							<a href="#" class="category-btn">Show all</a>

						</div>

					</div>

					<div class="category-item">

						<div class="category-img-box">
							<img src="./static/images/icons/glasses.svg" alt="glasses & lens"
								width="30">
						</div>

						<div class="category-content-box">

							<div class="category-content-flex">
								<h3 class="category-item-title">Glasses & lens</h3>

								<p class="category-item-amount">(68)</p>
							</div>

							<a href="#" class="category-btn">Show all</a>

						</div>

					</div>

					<div class="category-item">

						<div class="category-img-box">
							<img src="./static/images/icons/shorts.svg" alt="shorts & jeans"
								width="30">
						</div>

						<div class="category-content-box">

							<div class="category-content-flex">
								<h3 class="category-item-title">Shorts & jeans</h3>

								<p class="category-item-amount">(84)</p>
							</div>

							<a href="#" class="category-btn">Show all</a>

						</div>

					</div>

					<div class="category-item">

						<div class="category-img-box">
							<img src="./static/images/icons/tee.svg" alt="t-shirts"
								width="30">
						</div>

						<div class="category-content-box">

							<div class="category-content-flex">
								<h3 class="category-item-title">T-shirts</h3>

								<p class="category-item-amount">(35)</p>
							</div>

							<a href="#" class="category-btn">Show all</a>

						</div>

					</div>

					<div class="category-item">

						<div class="category-img-box">
							<img src="./static/images/icons/jacket.svg" alt="jacket"
								width="30">
						</div>

						<div class="category-content-box">

							<div class="category-content-flex">
								<h3 class="category-item-title">Jacket</h3>

								<p class="category-item-amount">(16)</p>
							</div>

							<a href="#" class="category-btn">Show all</a>

						</div>

					</div>

					<div class="category-item">

						<div class="category-img-box">
							<img src="./static/images/icons/watch.svg" alt="watch" width="30">
						</div>

						<div class="category-content-box">

							<div class="category-content-flex">
								<h3 class="category-item-title">Watch</h3>

								<p class="category-item-amount">(27)</p>
							</div>

							<a href="#" class="category-btn">Show all</a>

						</div>

					</div>

					<div class="category-item">

						<div class="category-img-box">
							<img src="./static/images/icons/hat.svg" alt="hat & caps"
								width="30">
						</div>

						<div class="category-content-box">

							<div class="category-content-flex">
								<h3 class="category-item-title">Hat & caps</h3>

								<p class="category-item-amount">(39)</p>
							</div>

							<a href="#" class="category-btn">Show all</a>

						</div>

					</div>

				</div>

			</div>

		</div>





		<!--
      - PRODUCT
    -->

		<div class="product-container">

			<div class="container">


				<!--
          - SIDEBAR
        -->

				<div class="sidebar  has-scrollbar" data-mobile-menu>

					<div class="sidebar-category">

						<div class="sidebar-top">
							<h2 class="sidebar-title">Category</h2>

							<button class="sidebar-close-btn" data-mobile-menu-close-btn>
								<ion-icon name="close-outline"></ion-icon>
							</button>
						</div>

						<ul class="sidebar-menu-category-list">

							<li class="sidebar-menu-category">
								<%
								for (categories cate : clist) {
								%>

								<button class="sidebar-accordion-menu" data-accordion-btn>

									<div class="menu-title-flex">
										<img src="./static/images/icons/dress.svg" alt="clothes"
											width="20" height="20" class="menu-title-img">

										<p class="menu-title">
											<a href="productList.jsp?category=<%=cate.getCategoryId()%>"
												class="sidebar-submenu-title"> <%=cate.getCategoryName()%>
											</a>
										</p>
									</div>

									<div>
										<ion-icon name="add-outline" class="add-icon"></ion-icon>
										<ion-icon name="remove-outline" class="remove-icon"></ion-icon>
									</div>

								</button>

								<ul class="sidebar-submenu-category-list" data-accordion>

									<li class="sidebar-submenu-category"><a href="#"
										class="sidebar-submenu-title">
											<p class="product-name">Shirt</p> <data value="300"
												class="stock" title="Available Stock">300</data>
									</a></li>

									<li class="sidebar-submenu-category"><a href="#"
										class="sidebar-submenu-title">
											<p class="product-name">shorts & jeans</p> <data value="60"
												class="stock" title="Available Stock">60</data>
									</a></li>

									<li class="sidebar-submenu-category"><a href="#"
										class="sidebar-submenu-title">
											<p class="product-name">jacket</p> <data value="50"
												class="stock" title="Available Stock">50</data>
									</a></li>

									<li class="sidebar-submenu-category"><a href="#"
										class="sidebar-submenu-title">
											<p class="product-name">dress & frock</p> <data value="87"
												class="stock" title="Available Stock">87</data>
									</a></li>

								</ul> <%
 }
 %>

							</li>


						</ul>

					</div>

					<div class="product-showcase">

						<h3 class="showcase-heading">best sellers</h3>

						<div class="showcase-wrapper">

							<div class="showcase-container">

								<div class="showcase">

									<a href="#" class="showcase-img-box"> <img
										src="./static/images/products/1.jpg" alt="baby fabric shoes"
										width="75" height="75" class="showcase-img">
									</a>

									<div class="showcase-content">

										<a href="#">
											<h4 class="showcase-title">baby fabric shoes</h4>
										</a>

										<div class="showcase-rating">
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
										</div>

										<div class="price-box">
											<del>$5.00</del>
											<p class="price">$4.00</p>
										</div>

									</div>

								</div>

								<div class="showcase">

									<a href="#" class="showcase-img-box"> <img
										src="./static/images/products/2.jpg"
										alt="men's hoodies t-shirt" class="showcase-img" width="75"
										height="75">
									</a>

									<div class="showcase-content">

										<a href="#">
											<h4 class="showcase-title">men's hoodies t-shirt</h4>
										</a>
										<div class="showcase-rating">
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star-half-outline"></ion-icon>
										</div>

										<div class="price-box">
											<del>$17.00</del>
											<p class="price">$7.00</p>
										</div>

									</div>

								</div>

								<div class="showcase">

									<a href="#" class="showcase-img-box"> <img
										src="./assets/images/products/3.jpg" alt="girls t-shirt"
										class="showcase-img" width="75" height="75">
									</a>

									<div class="showcase-content">

										<a href="#">
											<h4 class="showcase-title">girls t-shirt</h4>
										</a>
										<div class="showcase-rating">
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star-half-outline"></ion-icon>
										</div>

										<div class="price-box">
											<del>$5.00</del>
											<p class="price">$3.00</p>
										</div>

									</div>

								</div>

								<div class="showcase">

									<a href="#" class="showcase-img-box"> <img
										src="./static/images/products/4.jpg" alt="woolen hat for men"
										class="showcase-img" width="75" height="75">
									</a>

									<div class="showcase-content">

										<a href="#">
											<h4 class="showcase-title">woolen hat for men</h4>
										</a>
										<div class="showcase-rating">
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
										</div>

										<div class="price-box">
											<del>$15.00</del>
											<p class="price">$12.00</p>
										</div>

									</div>

								</div>

							</div>

						</div>

					</div>

				</div>



				<div class="product-box">

					<!--
            - PRODUCT MINIMAL
          -->

					<div class="product-minimal">

						<div class="product-showcase">

							<h2 class="title">New Arrivals</h2>

							<div class="showcase-wrapper has-scrollbar">

								<div class="showcase-container">

									<%
									List<products> Newlist = dao.getNewArrivals();
									for (products nl : Newlist) {
									%>

									<div class="showcase">

										<a href="productsDetails.jsp?product=<%=nl.getProductID()%>"
											class="showcase-img-box"> <img
											src="./static/images/product/<%=nl.getProductImage()%>"
											alt="relaxed short full sleeve t-shirt" width="70"
											class="showcase-img">
										</a>

										<div class="showcase-content">

											<a href="#">
												<h4 class="showcase-title"><%=nl.getProductName()%></h4>
											</a> <a href="#" class="showcase-category">Cloths</a>

											<div class="price-box">
												<p class="price"><%=nl.getProductPrice()%></p>
												<del><%=nl.getPriceAfterdiscount()%></del>
											</div>

										</div>

									</div>

									<%
									}
									%>

								</div>

							</div>

						</div>

						<div class="product-showcase">

							<h2 class="title">Trending</h2>

							<div class="showcase-wrapper has-scrollbar">

								<div class="showcase-container">

									<%
									List<products> trendinglist = dao.getNewArrivals();
									for (products nl : trendinglist) {
									%>

									<div class="showcase">

										<a href="productsDetails.jsp?product=<%=nl.getProductID()%>"
											class="showcase-img-box"> <img
											src="./static/images/product/<%=nl.getProductImage()%>"
											alt="relaxed short full sleeve t-shirt" width="70"
											class="showcase-img">
										</a>

										<div class="showcase-content">

											<a href="#">
												<h4 class="showcase-title"><%=nl.getProductName()%></h4>
											</a> <a href="#" class="showcase-category">Cloths</a>

											<div class="price-box">
												<p class="price"><%=nl.getProductPrice()%></p>
												<del><%=nl.getPriceAfterdiscount()%></del>
											</div>

										</div>

									</div>

									<%
									}
									%>

								</div>

							</div>

						</div>

						<div class="product-showcase">

							<h2 class="title">Top Rated</h2>

							<div class="showcase-wrapper has-scrollbar">

								<div class="showcase-container">

									<%
									List<products> toplist = dao.getNewArrivals();
									for (products nl : toplist) {
									%>

									<div class="showcase">

										<a href="productsDetails.jsp?product=<%=nl.getProductID()%>"
											class="showcase-img-box"> <img
											src="./static/images/product/<%=nl.getProductImage()%>"
											alt="relaxed short full sleeve t-shirt" width="70"
											class="showcase-img">
										</a>

										<div class="showcase-content">

											<a href="#">
												<h4 class="showcase-title"><%=nl.getProductName()%></h4>
											</a> <a href="#" class="showcase-category">Cloths</a>

											<div class="price-box">
												<p class="price"><%=nl.getProductPrice()%></p>
												<del><%=nl.getPriceAfterdiscount()%></del>
											</div>

										</div>

									</div>

									<%
									}
									%>

								</div>

							</div>

						</div>

					</div>



					<!--
            - PRODUCT FEATURED
          -->

					<div class="product-featured">
						<%
						List<products> pro = dao.getLetestDiscountedProduct();
						for (products product : pro) {
						%>

						<h2 class="title">Deal of the day</h2>

						<div class="showcase-wrapper has-scrollbar">

							<div class="showcase-container">

								<div class="showcase">

									<div class="showcase-banner">
										<img
											src="./static/images/product/<%=product.getProductImage()%>"
											alt="shampoo, conditioner & facewash packs"
											class="showcase-img">
									</div>

									<div class="showcase-content">

										<div class="showcase-rating">
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star-outline"></ion-icon>
											<ion-icon name="star-outline"></ion-icon>
										</div>

										<a href="#">
											<h3 class="showcase-title"><%=product.getProductName()%></h3>
										</a>

										<p class="showcase-desc"><%=product.getProductDisc()%></p>

										<div class="price-box">
											<p class="price"><%=product.getPriceAfterdiscount()%></p>

											<del><%=product.getProductPrice()%></del>
										</div>

										<button class="add-cart-btn">
											<a href="#?productid=<%=product.getProductID()%>"
												class="cart-btn" style="color: white;"
												onclick="add_to_cart(<%=product.getProductID()%>,'<%=product.getProductName()%>',<%=product.getPriceAfterdiscount()%>)">Add
												to cart</a>
										</button>
										<div class="showcase-status">
											<div class="wrapper">
												<p>
													already sold: <b><%=product.getproductStock()%></b>
												</p>

												<p>
													available: <b><%=product.getproductStock()%></b>
												</p>
											</div>

											<div class="showcase-status-bar"></div>
										</div>

										<div class="countdown-box">

											<p class="countdown-desc">Hurry Up! Offer ends in:</p>

											<div class="countdown">

												<div class="countdown-content">

													<p class="display-number">3</p>

													<p class="display-text">Days</p>

												</div>

												<div class="countdown-content">
													<p class="display-number">2</p>
													<p class="display-text">Hours</p>
												</div>

												<div class="countdown-content">
													<p class="display-number">59</p>
													<p class="display-text">Min</p>
												</div>

												<div class="countdown-content">
													<p class="display-number">00</p>
													<p class="display-text">Sec</p>
												</div>

											</div>

										</div>

									</div>

								</div>

							</div>

							<div class="showcase-container">

								<div class="showcase">

									<div class="showcase-banner">
										<img
											src="./static/images/product/<%=product.getProductImage()%>"
											alt="Rose Gold diamonds Earring" class="showcase-img">
									</div>

									<div class="showcase-content">

										<div class="showcase-rating">
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star-outline"></ion-icon>
											<ion-icon name="star-outline"></ion-icon>
										</div>

										<h3 class="showcase-title">
											<a href="#" class="showcase-title"><%=product.getProductName()%></a>
										</h3>

										<p class="showcase-desc"><%=product.getProductDisc()%></p>

										<div class="price-box">
											<p class="price"><%=product.getPriceAfterdiscount()%></p>
											<del><%=product.getProductPrice()%></del>
										</div>

										<button class="add-cart-btn">
											<a href="" class="cart-btn" style="color: white;"
												onclick="add_to_cart(<%=product.getProductID()%>, '<%=product.getProductName()%>', <%=product.getPriceAfterdiscount()%>);">Add
												to cart</a>
										</button>

										<div class="showcase-status">
											<div class="wrapper">
												<p>
													already sold: <b><%=product.getproductStock()%></b>
												</p>

												<p>
													available: <b><%=product.getproductStock()%></b>
												</p>
											</div>

											<div class="showcase-status-bar"></div>
										</div>

										<div class="countdown-box">

											<p class="countdown-desc">Hurry Up! Offer ends in:</p>

											<div class="countdown">
												<div class="countdown-content">
													<p class="display-number">360</p>
													<p class="display-text">Days</p>
												</div>

												<div class="countdown-content">
													<p class="display-number">24</p>
													<p class="display-text">Hours</p>
												</div>

												<div class="countdown-content">
													<p class="display-number">59</p>
													<p class="display-text">Min</p>
												</div>

												<div class="countdown-content">
													<p class="display-number">00</p>
													<p class="display-text">Sec</p>
												</div>
											</div>

										</div>

									</div>

								</div>

							</div>

						</div>
						<%
						}
						%>
					</div>



					<!--
            - PRODUCT GRID
          -->

					<div class="product-main">

						<h2 class="title">New Products</h2>

						<div class="product-grid">

							<%
							for (products products : list) {
							%>

							<div class="showcase">





								<div class="showcase-banner">
									<img
										src="./static/images/product/<%=products.getProductImage()%>"
										alt="Product Image" class="product-img default" width="300">
									<img
										src="./static/images/products/<%=products.getProductImage()%>"
										alt="Better Basics French Terry Sweatshorts"
										class="product-img hover" width="300">

									<p class="showcase-badge angle black">sale</p>

									<div class="showcase-actions">
										<button class="btn-action">
											<ion-icon name="heart-outline"></ion-icon>
										</button>

										<button class="btn-action">
											<ion-icon name="eye-outline"></ion-icon>
										</button>

										<button class="btn-action">
											<ion-icon name="repeat-outline"></ion-icon>
										</button>

										<button class="btn-action">
											<ion-icon name="bag-add-outline"></ion-icon>
										</button>
									</div>
								</div>

								<div class="showcase-content">
									<a href="#" class="showcase-category"><%=products.getProductName()%></a>

									<h3>
										<a href="#" class="showcase-title"><%=hideString.hidestr(products.getProductDisc())%></a>
									</h3>

									<div class="showcase-rating">
										<ion-icon name="star"></ion-icon>
										<ion-icon name="star"></ion-icon>
										<ion-icon name="star"></ion-icon>
										<ion-icon name="star-outline"></ion-icon>
										<ion-icon name="star-outline"></ion-icon>
									</div>

									<div class="price-box">
										<p class="price"><%=products.getPriceAfterdiscount()%>.0
										</p>
										<del><%=products.getProductPrice()%></del>
									</div>
									<div class="btn">
										<button class="btn custom-bg text-white"
											onclick="add_to_cart(<%=products.getProductID()%>, '<%=products.getProductName()%>', <%=products.getPriceAfterdiscount()%>);">Add
											To Cart</button>
										<button class="btn btn-success text-white">Buy Now</button>
									</div>

								</div>

							</div>
							<%
							}
							%>
						</div>
					</div>


					<!--
      - TESTIMONIALS, CTA & SERVICE
    -->

					<div>

						<div class="container">

							<div class="testimonials-box">

								<!--
            - TESTIMONIALS
          -->

								<div class="testimonial">

									<h2 class="title">testimonial</h2>

									<div class="testimonial-card">

										<img src="./static/images/testimonial-1.jpg" alt="alan doe"
											class="testimonial-banner" width="80" height="80">

										<p class="testimonial-name">Alan Doe</p>

										<p class="testimonial-title">CEO & Founder Invision</p>

										<img src="./static/images/icons/quotes.svg" alt="quotation"
											class="quotation-img" width="26">

										<p class="testimonial-desc">Lorem ipsum dolor sit amet
											consectetur Lorem ipsum dolor dolor sit amet.</p>

									</div>

								</div>



								<!--
            - CTA
          -->

								<div class="cta-container">

									<img src="./static/images/cta-banner.jpg"
										alt="summer collection" class="cta-banner"> <a href="#"
										class="cta-content">

										<p class="discount">25% Discount</p>

										<h2 class="cta-title">Summer collection</h2>

										<p class="cta-text">Starting @ $10</p>

										<button class="cta-btn">Shop now</button>

									</a>

								</div>



								<!--
            - SERVICE
          -->

								<div class="service">

									<h2 class="title">Our Services</h2>

									<div class="service-container">

										<a href="#" class="service-item">

											<div class="service-icon">
												<ion-icon name="boat-outline"></ion-icon>
											</div>

											<div class="service-content">

												<h3 class="service-title">Worldwide Delivery</h3>
												<p class="service-desc">For Order Over $100</p>

											</div>

										</a> <a href="#" class="service-item">

											<div class="service-icon">
												<ion-icon name="rocket-outline"></ion-icon>
											</div>

											<div class="service-content">

												<h3 class="service-title">Next Day delivery</h3>
												<p class="service-desc">UK Orders Only</p>

											</div>

										</a> <a href="#" class="service-item">

											<div class="service-icon">
												<ion-icon name="call-outline"></ion-icon>
											</div>

											<div class="service-content">

												<h3 class="service-title">Best Online Support</h3>
												<p class="service-desc">Hours: 8AM - 11PM</p>

											</div>

										</a> <a href="#" class="service-item">

											<div class="service-icon">
												<ion-icon name="arrow-undo-outline"></ion-icon>
											</div>

											<div class="service-content">

												<h3 class="service-title">Return Policy</h3>
												<p class="service-desc">Easy & Free Return</p>

											</div>

										</a> <a href="#" class="service-item">

											<div class="service-icon">
												<ion-icon name="ticket-outline"></ion-icon>
											</div>

											<div class="service-content">

												<h3 class="service-title">30% money back</h3>
												<p class="service-desc">For Order Over $100</p>

											</div>

										</a>

									</div>

								</div>

							</div>

						</div>

					</div>





					<!--
      - BLOG
    -->

					<div class="blog">

						<div class="container">

							<div class="blog-container has-scrollbar">

								<div class="blog-card">

									<a href="#"> <img src="./static/images/blog-1.jpg"
										alt="Clothes Retail KPIs 2021 Guide for Clothes Executives"
										width="300" class="blog-banner">
									</a>

									<div class="blog-content">

										<a href="#" class="blog-category">Fashion</a> <a href="#">
											<h3 class="blog-title">Clothes Retail KPIs 2021 Guide
												for Clothes Executives.</h3>
										</a>

										<p class="blog-meta">
											By <cite>Mr Admin</cite> /
											<time datetime="2022-04-06">Apr 06, 2022</time>
										</p>

									</div>

								</div>

								<div class="blog-card">

									<a href="#"> <img src="./static/images/blog-2.jpg"
										alt="Curbside fashion Trends: How to Win the Pickup Battle."
										class="blog-banner" width="300">
									</a>

									<div class="blog-content">

										<a href="#" class="blog-category">Clothes</a>

										<h3>
											<a href="#" class="blog-title">Curbside fashion Trends:
												How to Win the Pickup Battle.</a>
										</h3>

										<p class="blog-meta">
											By <cite>Mr Robin</cite> /
											<time datetime="2022-01-18">Jan 18, 2022</time>
										</p>

									</div>

								</div>

								<div class="blog-card">

									<a href="#"> <img src="./static/images/blog-3.jpg"
										alt="EBT vendors: Claim Your Share of SNAP Online Revenue."
										class="blog-banner" width="300">
									</a>

									<div class="blog-content">

										<a href="#" class="blog-category">Shoes</a>

										<h3>
											<a href="#" class="blog-title">EBT vendors: Claim Your
												Share of SNAP Online Revenue.</a>
										</h3>

										<p class="blog-meta">
											By <cite>Mr Selsa</cite> /
											<time datetime="2022-02-10">Feb 10, 2022</time>
										</p>

									</div>

								</div>

								<div class="blog-card">

									<a href="#"> <img src="./static/images/blog-4.jpg"
										alt="Curbside fashion Trends: How to Win the Pickup Battle."
										class="blog-banner" width="300">
									</a>

									<div class="blog-content">

										<a href="#" class="blog-category">Electronics</a>

										<h3>
											<a href="#" class="blog-title">Curbside fashion Trends:
												How to Win the Pickup Battle.</a>
										</h3>

										<p class="blog-meta">
											By <cite>Mr Pawar</cite> /
											<time datetime="2022-03-15">Mar 15, 2022</time>
										</p>

									</div>

								</div>

							</div>

						</div>

					</div>
	</main>





	<!--
    - FOOTER
  -->

	<footer>

		<div class="footer-category">

			<div class="container">

				<h2 class="footer-category-title">Brand directory</h2>

				<div class="footer-category-box">

					<h3 class="category-box-title">Fashion :</h3>

					<a href="#" class="footer-category-link">T-shirt</a> <a href="#"
						class="footer-category-link">Shirts</a> <a href="#"
						class="footer-category-link">shorts & jeans</a> <a href="#"
						class="footer-category-link">jacket</a> <a href="#"
						class="footer-category-link">dress & frock</a> <a href="#"
						class="footer-category-link">innerwear</a> <a href="#"
						class="footer-category-link">hosiery</a>

				</div>

				<div class="footer-category-box">
					<h3 class="category-box-title">footwear :</h3>

					<a href="#" class="footer-category-link">sport</a> <a href="#"
						class="footer-category-link">formal</a> <a href="#"
						class="footer-category-link">Boots</a> <a href="#"
						class="footer-category-link">casual</a> <a href="#"
						class="footer-category-link">cowboy shoes</a> <a href="#"
						class="footer-category-link">safety shoes</a> <a href="#"
						class="footer-category-link">Party wear shoes</a> <a href="#"
						class="footer-category-link">Branded</a> <a href="#"
						class="footer-category-link">Firstcopy</a> <a href="#"
						class="footer-category-link">Long shoes</a>
				</div>

				<div class="footer-category-box">
					<h3 class="category-box-title">jewellery :</h3>

					<a href="#" class="footer-category-link">Necklace</a> <a href="#"
						class="footer-category-link">Earrings</a> <a href="#"
						class="footer-category-link">Couple rings</a> <a href="#"
						class="footer-category-link">Pendants</a> <a href="#"
						class="footer-category-link">Crystal</a> <a href="#"
						class="footer-category-link">Bangles</a> <a href="#"
						class="footer-category-link">bracelets</a> <a href="#"
						class="footer-category-link">nosepin</a> <a href="#"
						class="footer-category-link">chain</a> <a href="#"
						class="footer-category-link">Earrings</a> <a href="#"
						class="footer-category-link">Couple rings</a>
				</div>

				<div class="footer-category-box">
					<h3 class="category-box-title">cosmetics :</h3>

					<a href="#" class="footer-category-link">Shampoo</a> <a href="#"
						class="footer-category-link">Bodywash</a> <a href="#"
						class="footer-category-link">Facewash</a> <a href="#"
						class="footer-category-link">makeup kit</a> <a href="#"
						class="footer-category-link">liner</a> <a href="#"
						class="footer-category-link">lipstick</a> <a href="#"
						class="footer-category-link">prefume</a> <a href="#"
						class="footer-category-link">Body soap</a> <a href="#"
						class="footer-category-link">scrub</a> <a href="#"
						class="footer-category-link">hair gel</a> <a href="#"
						class="footer-category-link">hair colors</a> <a href="#"
						class="footer-category-link">hair dye</a> <a href="#"
						class="footer-category-link">sunscreen</a> <a href="#"
						class="footer-category-link">skin loson</a> <a href="#"
						class="footer-category-link">liner</a> <a href="#"
						class="footer-category-link">lipstick</a>
				</div>

			</div>

		</div>

		<div class="footer-nav">

			<div class="container">

				<ul class="footer-nav-list">

					<li class="footer-nav-item">
						<h2 class="nav-title">Popular Categories</h2>
					</li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Fashion</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Electronic</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Cosmetic</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Health</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Watches</a></li>

				</ul>

				<ul class="footer-nav-list">

					<li class="footer-nav-item">
						<h2 class="nav-title">Products</h2>
					</li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Prices drop</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">New products</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Best sales</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Contact us</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Sitemap</a></li>

				</ul>

				<ul class="footer-nav-list">

					<li class="footer-nav-item">
						<h2 class="nav-title">Our Company</h2>
					</li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Delivery</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Legal Notice</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Terms and conditions</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">About us</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Secure payment</a></li>

				</ul>

				<ul class="footer-nav-list">

					<li class="footer-nav-item">
						<h2 class="nav-title">Services</h2>
					</li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Prices drop</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">New products</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Best sales</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Contact us</a></li>

					<li class="footer-nav-item"><a href="#"
						class="footer-nav-link">Sitemap</a></li>

				</ul>

				<ul class="footer-nav-list">

					<li class="footer-nav-item">
						<h2 class="nav-title">Contact</h2>
					</li>

					<li class="footer-nav-item flex">
						<div class="icon-box">
							<ion-icon name="location-outline"></ion-icon>
						</div>

						<address class="content">419 State 414 Rte Beaver Dams,
							New York(NY), 14812, USA</address>
					</li>

					<li class="footer-nav-item flex">
						<div class="icon-box">
							<ion-icon name="call-outline"></ion-icon>
						</div> <a href="tel:+607936-8058" class="footer-nav-link">(607)
							936-8058</a>
					</li>

					<li class="footer-nav-item flex">
						<div class="icon-box">
							<ion-icon name="mail-outline"></ion-icon>
						</div> <a href="mailto:example@gmail.com" class="footer-nav-link">example@gmail.com</a>
					</li>

				</ul>

				<ul class="footer-nav-list">

					<li class="footer-nav-item">
						<h2 class="nav-title">Follow Us</h2>
					</li>

					<li>
						<ul class="social-link">

							<li class="footer-nav-item"><a href="#"
								class="footer-nav-link"> <ion-icon name="logo-facebook"></ion-icon>
							</a></li>

							<li class="footer-nav-item"><a href="#"
								class="footer-nav-link"> <ion-icon name="logo-twitter"></ion-icon>
							</a></li>

							<li class="footer-nav-item"><a href="#"
								class="footer-nav-link"> <ion-icon name="logo-linkedin"></ion-icon>
							</a></li>

							<li class="footer-nav-item"><a href="#"
								class="footer-nav-link"> <ion-icon name="logo-instagram"></ion-icon>
							</a></li>

						</ul>
					</li>

				</ul>

			</div>

		</div>

		<div class="footer-bottom">

			<div class="container">

				<img src="./static/images/payment.png" alt="payment method"
					class="payment-img">

				<p class="copyright">
					Copyright &copy; <a href="#">Anon</a> all rights reserved.
				</p>

			</div>

		</div>

	</footer>






	<!--
    - custom js link
  -->
	<script src="./static/js/card.js"></script>

	<!--
    - ionicon link
  -->
	<script type="module"
		src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule
		src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>

</html>