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
					String cat = request.getParameter("category");

					productDAO dao = new productDAO(factoryDAO.getFactory());
					List<products> list = null;

					if (cat == null) {
						list = dao.getAllProducts();// Default to "all"
					} else if (cat.trim().equals("all")) {
						list = dao.getAllProducts();
					} else {
						int cid = Integer.parseInt(cat.trim());
						list = dao.getAllProductsById(cid);
					}

					categoryDAO cdao = new categoryDAO(factoryDAO.getFactory());
					List<categories> clist = cdao.getcategories();
					%>

					<p>
						products Available<%=list.size()%></p>


				</div>

			</div>

		</div>
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
							name="log-out-outline"></ion-icon>
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

								<p class="menu-title">
									<a href="productList.jsp?category=all"
										class="sidebar-submenu-title"> All Products </a>
								</p> <%
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
								<%
								for (products p : list) {
								%>

								<div class="showcase">

									<a href="#" class="showcase-img-box"> <img
										src="./static/images/product/<%=p.getProductImage()%>"
										alt="baby fabric shoes" width="75" height="75"
										class="showcase-img">
									</a>

									<div class="showcase-content">

										<a href="#">
											<h4 class="showcase-title"><%=p.getProductName()%></h4>
										</a>

										<div class="showcase-rating">
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
											<ion-icon name="star"></ion-icon>
										</div>

										<div class="price-box">
											<p class="price"><%=p.getPriceAfterdiscount()%></p>
											<del><%=p.getProductPrice()%></del>
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
									<p class="price"><%=products.getProductPrice()%></p>
									<del><%=products.getProductPrice()%></del>
								</div>
								<div class="btn">
									<button class="btn custom-bg text-white">Add To Cart</button>
									<button class="btn btn-success text-white">Buy Now</button>
								</div>

							</div>

						</div>
						<%
						}

						if (list.size() == 0) {
						out.print("<h1>not item is available</h1>");
						}
						%>
					</div>
				</div>
			</div>

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

								<address class="content">419 State 414 Rte Beaver
									Dams, New York(NY), 14812, USA</address>
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






			<!--- custom js link -->
			<script src="./static/js/script.js"></script>
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