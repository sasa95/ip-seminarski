<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="rs.Hotel"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lista hotela</title>

<%

ArrayList<Hotel>haha = (ArrayList<Hotel>)request.getAttribute("haha");

%>


</head>
<body>

		<c:forEach var="pom" items="${ls}">
			
			<ul>
				<li>Naziv: ${pom.naziv}</li>
				<li>Adresa: ${pom.adresa}</li>
				<li>Kategorija: ${pom.kategorija}</li>
				<li>Broj ležaja: ${pom.broj_lezaja}</li>	
			</ul>
			<a href="Servlet?id=${pom.hotelID}&akcija=jedanHotel">Detalji</a><br><br>
		</c:forEach>

		<c:forEach var="pom" items="${haha}">
			
			<ul>
				<li>Naziv: ${pom.naziv}</li>
				<li>Adresa: ${pom.adresa}</li>
				<li>Kategorija: ${pom.kategorija}</li>
				<li>Broj ležaja: ${pom.broj_lezaja}</li>	
			</ul>
			<a href="Servlet?id=${pom.hotelID}&akcija=jedanHotel">Detalji</a><br><br>
		</c:forEach>
		
		<%
			out.println(haha.size());
		%>
		
		<%System.out.println(haha); %>

</body>
</html>