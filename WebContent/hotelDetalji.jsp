<%@page import="rs.SobaTip_sobe"%>
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
<title>Detalji hotela</title>
</head>
<body>
<%
	Hotel h = (Hotel)request.getAttribute("h");
	ArrayList<SobaTip_sobe> lsts = (ArrayList<SobaTip_sobe>)request.getAttribute("lsts");
%>

	<h1>${h.naziv}</h1>
	<p>${h.opis}</p>
	<ul>
		<li>Adresa:${h.adresa}</li>
		<li>Kategorija:${h.kategorija}</li>
		<li>Broj ležaja:${h.broj_lezaja}</li>
	</ul>

<table>
	<tr>
		<th>Tip sobe</th>
		<th>Broj soba</th>
	</tr>
	
	<c:forEach var="pom" items="${lsts}">
		<tr>
			<td>${pom.nazivTipaSobe}</td>
			<td>${pom.brojSoba}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>