<%@page import="rs.Vrsta_aktivnostiAktivnost"%>
<%@page import="rs.Aktivnost"%>
<%@page import="rs.Tip_sobe"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="rs.Trzni_centar"%>
<%@page import="rs.Tretman"%>
<%@page import="rs.Usluga"%>
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
	ArrayList<Usluga> lsusluga = (ArrayList<Usluga>)request.getAttribute("lsusluga");
	ArrayList<Tretman> lstretman = (ArrayList<Tretman>)request.getAttribute("lstretman");
	ArrayList<Trzni_centar> lscentar = (ArrayList<Trzni_centar>)request.getAttribute("lscentar");
	ArrayList<Vrsta_aktivnostiAktivnost> lsaktivnost = (ArrayList<Vrsta_aktivnostiAktivnost>)request.getAttribute("lsaktivnost");
	ArrayList<Tip_sobe>lsts_bool = (ArrayList<Tip_sobe>)request.getAttribute("lsts_bool");
	
	
	String id = request.getParameter("id");
	String akcija = request.getParameter("akcija");
	String fullString = "/Servlet?id="+id+"&akcija="+akcija;
	
	HttpSession loginSesija = request.getSession();
	loginSesija.setAttribute("fullString", fullString);
	


%>

	<h1>${h.naziv}</h1>
	<img src="img/hoteli/${h.hotelID}.jpg"/>
	<p>${h.opis}</p>

	<ul>
		<li>Adresa: ${h.adresa}</li>
		<li>Kategorija: ${h.kategorija}</li>
		<li>Broj ležaja: ${h.broj_lezaja}</li>
	</ul>

	
	<%
		if(lsts_bool.size()>0){
	%>	
	<h2><a href="Servlet_rezervacija?hotelID=${h.hotelID}">REZERVIŠI</a></h2>
	<%}else {%>
	<h2>REZERVACIJA NEDOSTUPNA</h2>
	<%} %>
	<table>
		<tr>
			<th>Vrsta usluge</th>
			<th>Cena usluge</th>
		</tr>
		
		<c:forEach var="pom" items="${lsusluga}">
			<tr>
				<td>${pom.vrsta_usluge}</td>
				<td>${pom.cena}</td>
			</tr>
		</c:forEach>
	</table>

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
	<h3>Tretmani</h3>
		<ol>
			<c:forEach var="pom" items="${lstretman}">
				<li>${pom.naziv }</li>		
			</c:forEach>
		</ol>
		
	<h3>Tržni centri</h3>
		<ol>
			<c:forEach var="pom" items="${lscentar}">
				<li>${pom.naziv} - ${pom.lokacija} - <a href="Servlet?centarID=${pom.trzni_centarID}&akcija=detaljiCentra&hotelID=${h.hotelID}">Detalji</a></li>
			</c:forEach>
		</ol>
	<h3>Vrste aktivnosti:</h3>
		<ol>
			
		
			<c:forEach var="pom" items="${lsaktivnost }">
				<li>${pom.vrstaAktivnosti} - <a href="Servlet?akcija=AktivnostDetalji&aktivnostID=${pom.vrsta_aktivnostiID}&hotelID=${h.hotelID}&akt=${pom.aktivnostID}">Detalji</a></li>
			</c:forEach>
		</ol>
</body>
</html>