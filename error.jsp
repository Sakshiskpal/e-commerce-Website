<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <h1>Error Occurred</h1>
    <p><%= request.getSession().getAttribute("errorMessage") %></p>
    <a href="index.jsp">Go Back</a>
</body>
</html>
