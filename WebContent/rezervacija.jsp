<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rezervacija</title>
</head>
<body>
	<%
		HttpSession loginSesija = request.getSession();
		String username = (String)loginSesija.getAttribute("username");
		if(username!=null){
	%>
	<h2>Popunite formu za rezervaciju</h2>
	<%}else response.sendRedirect("prijava.jsp"); %>
</body>
</html>