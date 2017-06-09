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
<title>Detalji tržnog centra</title>
</head>
<body>
<%
	Trzni_centar nazivCentra = (Trzni_centar)request.getAttribute("nazivCentra");
	ArrayList<Trzni_centar_prodavnica> lsprodavnica = (ArrayList<Trzni_centar_prodavnica>)request.getAttribute("lsprodavnica");
%>

<h1>${nazivCentra.naziv }</h1>

<ol>
	<c:forEach var="pom" items="${lsprodavnica}">
			<li>${pom.nazivProdavnice } - ${pom.lokacija}</li>
	</c:forEach>
</ol>
</body>
