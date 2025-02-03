<%@page import="entities.categories"%>
<%@page import="java.util.List"%>
<%@page import="fabric.DAO.categoryDAO"%>
<%@page import="fabric.DAO.factoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="./static/css/common-style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Add Product</title>
</head>
<body>

<%@include file="component/header.jsp" %>

<% if (session.getAttribute("message") != null) { %>
    <div class="alert alert-success"><%= session.getAttribute("message") %></div>
    <% session.removeAttribute("message"); %>
<% } %>

<% if (session.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-danger"><%= session.getAttribute("errorMessage") %></div>
    <% session.removeAttribute("errorMessage"); %>
<% } %>

<div class="container">
    <div class="label">
        <h2 class="text-center">Add Product</h2>
    </div>
    <div class="card" style="width: 38rem;">
        <div class="card-body">
            <div class="form">
                <form action="addProductServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="operation" value="ADD_PRODUCT">

                    <div class="mb-3">
                        <label for="productName" class="form-label">Product Name</label>
                        <input type="text" style="width: 500px;" class="form-control" name="product_name" id="productName">
                    </div>

                    <div class="mb-3">
                        <label for="productDescription" class="form-label">Product Description</label>
                        <input type="text" style="width: 500px;" name="product_disc" class="form-control" id="productDescription">
                    </div>

                    <div class="mb-3">
                        <label for="productPrice" class="form-label">Product Price</label>
                        <input type="text" style="width: 500px;" class="form-control" name="product_price" id="productPrice">
                    </div>

                    <div class="mb-3">
                        <label for="productStock" class="form-label">Product Discount</label>
                        <input type="number" style="width: 500px;" name="product_discount" class="form-control" id="productStock">
                    </div>
                    

                    <div class="mb-3">
                        <label for="productStock" class="form-label">Product Stock</label>
                        <input type="number" style="width: 500px;" name="product_stock" class="form-control" id="productStock">
                    </div>
                    
                    <%
                        categoryDAO cdao = new categoryDAO(factoryDAO.getFactory());
                        List<categories> list = cdao.getcategories();
                        if (list != null) {
                    %>
                    <div class="form-group">
                        <label for="categoryId" class="form-label">Select Category</label>
                        <select name="catId" class="form-control" id="categoryId">
                            <% for (categories cat : list) { %>
                                <option value="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <% } else { %>
                        <div class="alert alert-warning">No categories found!</div>
                    <% } %>

                    <div class="mb-3">
                        <label class="form-label" for="productImage">Upload Image</label>
                        <input type="file" class="form-control" style="width: 500px;" name="product_img" id="productImage">
                    </div>

                    <button type="submit" class="btn btn-primary align-center">Add Product</button>

                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/js/bootstrap.min.js"></script>

</body>
</html>
