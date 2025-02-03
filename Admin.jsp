<%@page import="fabric.DAO.userCountDAO"%>
<%@page import="entities.categories"%>
<%@page import="fabric.DAO.categoryDAO"%>
<%@page import="entities.products"%>
<%@page import="java.util.List"%>
<%@page import="fabric.DAO.factoryDAO"%>
<%@page import="fabric.DAO.productDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="entities.Users"%>


<%
// Debugging session and user role
System.out.println("Session ID: " + session.getId());
Users user1 = (Users) session.getAttribute("current-user");
if (user1 == null) {
	session.setAttribute("message", "You are not logged In!");
	response.sendRedirect("login.jsp");
	return;
} else {
	if (user1.getUserRole().equals("customer")) {
		session.setAttribute("message", "You are not Admin In!");
		response.sendRedirect("login.jsp");
		return;
	}
	System.out.println("Logged-in user: " + user1.getUserName());
	System.out.println("User role: " + user1.getUserRole());
}
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./static/css/common-style.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<meta charset="UTF-8">
<!--   <link rel="stylesheet" href="./static/css/style-prefix.css">-->
<title>Admin page</title>
</head>
<body>
	<%@include file="component/header.jsp"%>

	<!-- Show message if there is one in the session -->
	<%
	String message = (String) session.getAttribute("message");
	if (message != null) {
	%>
	<div class="alert alert-info">
		<%=message%>
	</div>
	<%
	session.removeAttribute("message");
	}
	%>


	<h1>This is admin page</h1>
	    <%
    
        productDAO dao = new productDAO(factoryDAO.getFactory());
        List<products> list = dao.getAllProducts();

        categoryDAO cdao = new categoryDAO(factoryDAO.getFactory());
        List<categories> clist = cdao.getcategories();
        
        userCountDAO udao = new userCountDAO(factoryDAO.getFactory());
        long count = udao.getUserCount();
    %>




	<div class="container admin">
		<div class="row mt-3">
			<div class="col-md-4">



				<div class="card " style="width: 18rem;">
					<div class="container">
						<img src="static/images/logo/boy.png"
							class="rounded mx-auto d-block img-fuid"
							style="max-width: 125px;" alt="...">
					</div>
					<div class="card-body text-center">
						<h5 class="card-title">Users</h5>
						<p class="card-text">
							<%=count%>
						</p>
					</div>
				</div>

			</div>
			<div class="col-md-4 ">
				<div class="card" style="width: 18rem;">
					<div class="container">
						<img src="static/images/logo/add-product.png"
							class="rounded mx-auto d-block img-fuid"
							style="max-width: 125px;" alt="...">
					</div>
					<div class="card-body text-center">
						<h5 class="card-title">Products</h5>
						<p class="card-text"><%=list.size()%></p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card " style="width: 18rem;">
					<div class="container">
						<img src="static/images/products/options.png"
							class="rounded mx-auto d-block img-fuid"
							style="max-width: 125px;" alt="...">
					</div>
					<div class="card-body text-center">
						<h5 class="card-title">Categories</h5>
						<p class="card-text"><%=clist.size()%></p>

					</div>
				</div>
			</div>
		</div>


		<div class="row">
			<div class="col-md-6 mt-4 ">
				<div class="card " style="width: 18rem;">
					<div class="container">
						<img src="static/images/logo/add-product.png"
							class="rounded mx-auto d-block img-fuid"
							style="max-width: 125px;" alt="...">
					</div>
					<div class="card-body text-center">
						<h5 class="card-title">Products</h5>
					
						<a href="AddProduct.jsp" class="btn btn-primary">Add Product</a>
					</div>
				</div>
			</div>

			<div class="col-md-6 mt-4">
				<div class="card" style="width: 18rem;">
					<div class="img" style="padding-left: 20px;">
						<div class="container">
							<img src="static/images/products/options.png"
								class="rounded mx-auto d-block img-fuid"
								style="max-width: 125px;" alt="...">
						</div>
						<div class="card-body text-center">
							<h5 class="card-title">Categories</h5>
		
							<a href="AddCategory.jsp" class="btn btn-primary">Add
								Categories</a>
						</div>
					</div>
				</div>
			</div>
	</div>
	</div>
	<%
	
    %>

	<!--toggle model details-->



	<!-- Include Bootstrap 4 JS and Popper.js -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/js/bootstrap.min.js"></script>


</body>
</html>