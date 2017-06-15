<%@page import="java.util.ArrayList"%>
<%@page import="rs.Korisnik"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Prijava</title>
</head>
<body>


	<h1>${msg}</h1>
	<% 
		HttpSession loginSesija = request.getSession();
		String username = (String)loginSesija.getAttribute("username");
		if(username==null){
	%>
	<form action="Servlet_sesija" method="post">
		<label for="username">Korisničko ime:</label>
		<input type="text" name="username" id="username" value="${param.username}"><br>
		<label for="password">Lozinka:</label>
		<input type="password" name="password"><br>
		<input type="submit" value="Prijava" name="akcija">
	</form>
	<%}else response.sendRedirect("index.jsp"); %>
</body>
</html>