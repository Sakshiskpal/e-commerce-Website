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
	boolean loggedIn = false;
	String email = "";
	if (cookies != null) {
		for (Cookie c : cookies) {
	if (c.getName().equals("user_id")) {
		loggedIn = true;
		email = c.getValue();
		break;
	}
		}
	}
	if (!loggedIn) {
		out.print("You are not logged in. Please log in first.");
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

<!-- Favicon -->
<link rel="shortcut icon" href="./static/images/logo/favicon.ico"
	type="image/x-icon">

<!-- Custom CSS -->
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<script src="./static/js/card.js"></script>

<link rel="stylesheet" href="./static/css/style-prefix.css">
<link rel="stylesheet" href="./static/css/card.css">
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">
</head>

<body>
	<div class="overlay" data-overlay></div>

	<!-- Header -->
	<div class="header-top">
		<div class="container">
			<ul class="header-social-container">
				<li><a href="#" class="social-link"><ion-icon
							name="logo-facebook"></ion-icon></a></li>
				<li><a href="#" class="social-link"><ion-icon
							name="logo-twitter"></ion-icon></a></li>
				<li><a href="#" class="social-link"><ion-icon
							name="logo-instagram"></ion-icon></a></li>
				<li><a href="#" class="social-link"><ion-icon
							name="logo-linkedin"></ion-icon></a></li>
			</ul>
			<div class="header-alert-news">
				<p>
					<b>Free Shipping</b> This Week Order Over - 500/-
				</p>
			</div>
			<div class="header-top-actions">
				<%
				String cat = request.getParameter("category");

				productDAO dao = new productDAO(factoryDAO.getFactory());
				List<products> list = null;

				if (cat == null || cat.trim().equals("all")) {
					list = dao.getAllProducts();
				} else {
					try {
						int cid = Integer.parseInt(cat.trim());
						list = dao.getAllProductsById(cid);
					} catch (NumberFormatException e) {
						list = dao.getAllProducts(); // Fallback if parsing fails
					}
				}

				categoryDAO cdao = new categoryDAO(factoryDAO.getFactory());
				List<categories> clist = cdao.getcategories();
				%>
				<p>
					Products Available:
					<%=list.size()%></p>
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
				<a href="login.jsp" class="action-btn" id="loginButton"> <ion-icon
						name="person-outline"></ion-icon> <span>Login</span>
				</a>
				<%
				} else {
				%>
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



	<div>
		<div class="header">
			<div class="back-errow">
				<span class="errow"><-</span>
			</div>
			<div class="bag-disc">
				<p>Bag</p>
				<span> ( 1 items )</span>

			</div>
		</div>
	</div>
	</div>
	<div class="cart-body">
		<div class="login-redirect">
			<div class="login-container">
				<p color="#3a4047">Get Started & grab your best Deal!</p>
				<button class="login-register">Login / Register</button>
			</div>

		</div>
		<div class="cart-product">
			<section>
				<div class="container">
					<h2 class="px-5 p-2">My shopping cart</h2>
					<div class="cart">
						<div class="col-md-12 col-lg-10 mx-auto">
							<div class="cart-item">
								<div class="row">
									<div class="col-md-7 center-item">
										<img src="images/product-1.png" alt="">
										<h5>iPhone 11 128GB Black( $1219 )</h5>
									</div>

									<div class="col-md-5 center-item">
										<div class="input-group number-spinner">
											<button id="phone-minus" class="btn btn-default">
												<i class="fas fa-minus"></i>
											</button>
											<input id="phone-number" type="number" min="0"
												class="form-control text-center" value="1">
											<button id="phone-plus" class="btn btn-default">
												<i class="fas fa-plus"></i>
											</button>
										</div>
										<h5>
											$ <span id="phone-total">1219</span>
										</h5>
										<img src="images/remove.png" alt="" class="remove-item">
									</div>
								</div>
							</div>

							<div class="cart-item">
								<div class="row">
									<div class="col-md-7 center-item mx-auto">
										<img src="images/product-2.png" alt="">
										<h5>iPhone 11 Silicone Case - Black( $59 )</h5>
									</div>
									<div class="col-md-5 center-item">
										<div class="input-group number-spinner">
											<button id="case-minus" class="btn btn-default">
												<i class="fas fa-minus"></i>
											</button>
											<input id="case-number" type="number" min="0"
												class="form-control text-center" value="1">
											<button id="case-plus" class="btn btn-default">
												<i class="fas fa-plus"></i>
											</button>

										</div>
										<h5>
											$ <span id="case-total">59</span>
										</h5>
										<img src="images/remove.png" alt="" class="remove-item">
									</div>
								</div>
							</div>

							<div class="cart-item">
								<div class="row g-2">

									<div class="col-6">
										<h5>Subtotal:</h5>
										<h5>Tax:</h5>
										<h5>Total:</h5>
									</div>

									<div class="col-6 status">
										<h5>
											$<span id="sub-total">1,278</span>
										</h5>
										<h5>
											$<span id="tax-amount">0</span>
										</h5>
										<h5>
											$<span id="total-price">1,278</span>
										</h5>
									</div>

								</div>
							</div>
							<div class="col-md-12 pt-4 pb-4">
								<button type="button" class="btn btn-success check-out">Check
									Out</button>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<div class="cart-coupons">
			<div class="flex">
				<div class="" discount-img></div>
				<div class="coupon-desc">
					<span>Coupons</span>
					<p>Apply now and save extra!</p>
				</div>
				<div class="end-icon">
					<a href="#">></a>
				</div>
			</div>
		</div>
		<div class="payment-details">
			<div class="container">
				<div class="tital">
					<p>Price Details
				</div>
				<div class="content">
					<div class="bag">
						<div class="bag-mrp">
							<p>
								Bag MRP <span>(2 items)</span>
						</div>
						<div class="bag-price">7888</div>
					</div>
					<div class="discount">
						<div class="bag-dis">
							<p>Bag Discount
						</div>
						<div class="bag-price">7888</div>
					</div>
					<div class="shipping">
						<div class="bag-shipping-charges">
							<p>
								Shipping<span>icon</span>
						</div>
						<div class="bag-price">Free</div>
					</div>
				</div>
			</div>
		</div>
		<div class="togel">
			<p>
				You are saving<%

			%>
				on this order
			</p>
		</div>
	</div>
	<div class="footer-layout">
		<div class="total">
			<div class="price">
				<span>1408</span>
			</div>
			<div class="price">
				<span>Grand Total</span>
			</div>
		</div>
		<div class="proceed">
			<button>
				<a href="">Proceed</a> <span> -></span>
			</button>
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
					Copyright &copy; <a href="#">FabricFusion</a> all rights reserved.
				</p>

			</div>

		</div>

	</footer>






	<!--
    - custom js link
    
  -->


	<!--
    - ionicon link
  -->
	<script type="module"
		src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule
		src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>
