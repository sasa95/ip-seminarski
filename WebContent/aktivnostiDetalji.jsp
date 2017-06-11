<%@page import="rs.Hotel_aktivnost"%>
<%@page import="rs.Hotel"%>
<%@page import="rs.Hotel_aktivnost"%>
<%@page import="rs.Aktivnost"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="rs.Trzni_centar"%>
<%@page import="rs.Trzni_centar_prodavnica"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Detalji aktivnosti</title>
</head>
<body>
<%
	Hotel h = (Hotel)request.getAttribute("h");
	Vrsta_aktivnosti nazivAktivnosti = (Vrsta_aktivnosti)request.getAttribute("nazivAktivnosti");
	ArrayList<Aktivnost> akt = (ArrayList<Aktivnost>)request.getAttribute("akt");
	ArrayList<Hotel_aktivnost>lsakt = (ArrayList<Hotel_aktivnost>)request.getAttribute("lsakt");
%>

	<h1>${nazivAktivnosti.naziv_vrste_aktivnosti }</h1>

	
	
	<h2>Detalji:</h2>
	<c:forEach var="pom" items="${akt}">
			<h3>${pom.naziv }</h3>
			<p>${pom.opis }</p>
	</c:forEach>
	<c:forEach var="pom" items="${lsakt}">
			<p>Lokacija: ${pom.mesto_odrzavanja }</p>
			<p>Datum i vreme održavanja: ${pom.vreme_odrzavanja }</p>
	</c:forEach>
</body>
