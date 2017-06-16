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
	ArrayList<Rezervacija> lsrez = (ArrayList<Rezervacija>)loginSesija.getAttribute("lsrez");
	ArrayList<Hotel_aktivnost> lsakt = (ArrayList<Hotel_aktivnost>)loginSesija.getAttribute("lsakt");
	
	
	if(username!=null && lsrez.size()>0){
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profil korisnika</title>
</head>
<body>
${msg }
	
	<c:forEach var="rez" items="${lsrez}">	
		<ul>
		<li>Datum prijavljivanja: ${rez.datum_prijavljivanja}</li>
		<li>Datum odlaska: ${rez.datum_odlaska}</li>
		<li>Broj lične karte: ${rez.broj_licne_karte}</li>
		<li>Soba: ${rez.sobaID }</li>
		<li>Hotel: ${rez.hotelID }</li>
		<li>Usluga: ${rez.uslugaID }</li>		
		</ul>
	</c:forEach>
	
	
	<c:forEach var="rez" items="${lsakt}">	
		<ul>
			<li>Naziv: ${rez.naziv}</li>
			<li>Datum: ${rez.datum_odrzavanja}</li>
			<li>Vreme: ${rez.vreme_odrzavanja}</li>
			<li>Mesto: ${rez.mesto_odrzavanja}</li>
		</ul>
	</c:forEach>
	
	
	
</body>
</html>

<%}else {
	String url = request.getRequestURL().toString();
	response.sendRedirect("prijava.jsp"); 
}
%>