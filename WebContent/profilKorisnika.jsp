<%@page import="rs.Hotel_Rezervacija_Usluga"%>
<%@page import="rs.Hotel_aktivnost"%>
<%@page import="rs.Rezervacija"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<%
	HttpSession loginSesija = request.getSession();
	String username = (String)loginSesija.getAttribute("username");
	ArrayList<Hotel_Rezervacija_Usluga> lsrez = (ArrayList<Hotel_Rezervacija_Usluga>)loginSesija.getAttribute("lsrez");
	ArrayList<Hotel_aktivnost> lsakt = (ArrayList<Hotel_aktivnost>)loginSesija.getAttribute("lsakt");
	
	
	if(username!=null){
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profil korisnika</title>
</head>
<body>
	<%
		if(lsrez.size()>0){
	%>	
	<h2>Rezervacije:</h2>
	<c:forEach var="rez" items="${lsrez}">	
		<ul>
			<li>Hotel: ${rez.naziv }</li>
			<li>Usluga: ${rez.vrsta_usluge}</li>
			<li>Soba: ${rez.sobaID }</li>
			<li>Datum prijavljivanja: ${rez.datum_prijavljivanja}</li>
			<li>Datum odlaska: ${rez.datum_odlaska}</li>
			<li>Broj lične karte: ${rez.broj_licne_karte}</li>
		</ul>
	</c:forEach>
	
	<%} else { %>
	<h2>Nemate rezervacije</h2>
	<%} %>
	
	
	<%
		if(lsakt.size()>0){
	%>
	
	<h2>Dodate aktivnosti</h2>
	<c:forEach var="akt" items="${lsakt}">	
		<ul>
			<li>Naziv: ${akt.naziv}</li>
			<li>Datum: ${akt.datum_odrzavanja}</li>
			<li>Vreme: ${akt.vreme_odrzavanja}</li>
			<li>Mesto: ${akt.mesto_odrzavanja}</li>
		</ul>
	</c:forEach>
	
	<%}else { %>
	<h2>Nemate dodatih aktivnosti</h2>
	<%} %>
	
	
</body>
</html>

<%}else {
	String url = request.getRequestURL().toString();
	response.sendRedirect("prijava.jsp"); 
}
%>