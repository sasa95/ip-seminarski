<%@page import="rs.Vrsta_aktivnostiAktivnost"%>
<%@page import="rs.Korisnik"%>
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
	ArrayList<Vrsta_aktivnostiAktivnost>lsaktivnost=(ArrayList<Vrsta_aktivnostiAktivnost>)request.getAttribute("lsaktivnost");
	HttpSession loginSesija = request.getSession();
	Korisnik kor = (Korisnik)loginSesija.getAttribute("kor");
	
	String aktivnostID = request.getParameter("aktivnostID");
	String hotelID = request.getParameter("hotelID");
	String aktt = request.getParameter("akt");
	String returnString = "Servlet?akcija=AktivnostDetalji&aktivnostID="+aktivnostID+"&hotelID="+hotelID+"&akt="+aktt;
	
	loginSesija.setAttribute("returnString",returnString);
	
	Boolean akt_bool;
	if(kor!=null){
		 akt_bool = (Boolean)request.getAttribute("akt_bool");
	}
	
	else {
		akt_bool = false;
	}
	
	


	
	
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
	
	<%
		if(!akt_bool){
	%>
	
	<c:forEach var="pom" items="${akt}">
		<a href="Servlet_profil?akcija=zanimljivo&akt=${pom.aktivnostID}">Zanima me</a>
	</c:forEach>
	
	<%}else{ %>
		<h3>Dodato</h3>
	<%} %>
	
	
	
</body>
