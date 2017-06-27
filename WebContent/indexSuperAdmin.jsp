<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
     
<%
	HttpSession superAdminSesija = request.getSession();
	String adminUsername = (String)superAdminSesija.getAttribute("adminUsername");
	
	if(adminUsername!=null && !adminUsername.equals("")){
%>    
     
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
</head>
<body>
	<h1>Dobrodošli, ${adminUsername}</h1>
	
	<ul>
		<li><a href="administrator?akcija=tabelaHoteli">Hoteli</a></li>
		<li><a href="administrator?akcija=tabelaKorisnici">Korisnici</a></li>
		<li><a href="administrator?akcija=tabelaRezervacije">Rezervacije</a></li>
	</ul>
	
	<a href="administrator?akcija=logout">Odjava</a><br>
</body>
</html>
<%}else { response.sendRedirect("prijavaSuperAdmin.jsp");}%>