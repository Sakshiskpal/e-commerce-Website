<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./static/css/common-style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<title>Insert title here</title>

<!-- Include Bootstrap 4 JS and Popper.js -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/js/bootstrap.min.js"></script>

</head>
<body>

<%@include file="component/header.jsp" %>
<div class="container">
	<div class="form-group">
	
		<form action="ProductOperationServlet" method="post">
		<input type="hidden" name="operation" value="addcategory">
  <div class="mb-3">
    <label for="category" class="form-label">Category Name</label>
    <input type="text" class="form-control" name="category_name" id="addcategory" aria-describedby="emailHelp">
  </div>
  <div class="mb-3">
    <label for="categoriesName" class="form-label">Description</label>
    <input type="discription" class="form-control" name="category_disc" id="Categories Description">
  </div>
  <button type="submit" class="btn btn-primary">Add Category</button>
</form>
</div>
</div>
</body>
</html>