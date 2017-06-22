<%@page import="rs.Hotel_Rezervacija_Usluga"%>
<%@page import="rs.Hotel"%>
<%@page import="rs.Korisnik"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
     
<%
	HttpSession adminSesija = request.getSession();
	String adminUsername = (String)adminSesija.getAttribute("adminUsername");
	Hotel hotel = (Hotel)request.getAttribute("hotel");
	ArrayList<Hotel_Rezervacija_Usluga>korisnici = (ArrayList<Hotel_Rezervacija_Usluga>)request.getAttribute("rezervacije");
	String status = request.getParameter("status");
	if(adminUsername!=null && !adminUsername.equals("")){
		int hot_id = (Integer)adminSesija.getAttribute("hot_id");
%>    
     
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
</head>
<body>
	<h1>Rezervacije u hotelu ${hotel.naziv}</h1>
	<table border=1>
		<tr>
			<th>ID</th>
			<th>Datum prijavljivanja</th>
			<th>Datum odlaska</th>
			<th>Lična karta</th>
			<th>Soba</th>
			<th>Vrsta usluge</th>
			<th></th>
		<tr>
		<c:forEach var="pom" items="${rezervacije}">
			<tr>
				<td>${pom.rezervacijaID}</td>
				<td>${pom.datum_prijavljivanja}</td>
				<td>${pom.datum_odlaska}</td>
				<td>${pom.broj_licne_karte}</td>
				<td>${pom.sobaID}</td>
				<td>${pom.vrsta_usluge}</td>
				<td><a href="Servlet_admin?akcija=obrisiRezervaciju&rezervacijaID=${pom.rezervacijaID}">Obriši</a></td>
			</tr>
		</c:forEach>
	</table>
	<% if(status!=null && status.equals("ok")){ %>
		<h3>Uspešno brisanje rezervacije</h3>
	<%} %>
</body>
</html>
<%}else { response.sendRedirect("prijava.jsp");}%>