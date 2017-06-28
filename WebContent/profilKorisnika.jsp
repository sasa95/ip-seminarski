<%@page import="rs.Korisnik"%>
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
	
	//Korisnik kor = (Korisnik)loginSesija.getAttribute("kor");
	
	ArrayList<Hotel_Rezervacija_Usluga> lsrez = (ArrayList<Hotel_Rezervacija_Usluga>)loginSesija.getAttribute("lsrez");
	ArrayList<Hotel_aktivnost> lsakt = (ArrayList<Hotel_aktivnost>)loginSesija.getAttribute("lsakt");
	String msg = request.getParameter("msg");
	
	if(username!=null){
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profil korisnika</title>
</head>
<body>
	<img src="img/korisnici/${korisnik.korisnicko_ime}.jpg"/>
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
	
	<h2>Podaci o korisniku:</h2>
	<h2><%if(msg!=null){out.println(msg);}%></h2>
	<form action="Servlet_profil" method="post">
		<label for="broj_licne_karte">Broj lične karte: </label>
		<input required="required" type="number" max="999999999" placeholder="Npr. 001234567" name="broj_licne_karte"  value="${korisnik.broj_licne_karte}"><br>
		
		<label for="ime">Ime: </label>
		<input required="required" type="text" placeholder="Npr. Petar" name="ime"  value="${korisnik.ime}"><br>
		
		<label for="prezime">Prezime: </label>
		<input required="required" type="text" placeholder="Npr. Petrović" name="prezime"  value="${korisnik.prezime}"><br>
		
		<label for="adresa">Adresa: </label>
		<input required="required" type="text" placeholder="Npr. Svetog Save 66, Čačak" name="adresa"  value="${korisnik.adresa}"><br>
		
		<label for="email">Email: </label>
		<input required="required" type="email" placeholder="Npr. petarpetrovic95@gmail.com" name="email"  value="${korisnik.email}"><br><br>
		
		<label for="korisnicko_ime">Korisničko ime: </label>
		<input disabled="disabled" type="text" placeholder="Npr. petar_petrovic" name="korisnicko_ime"  value="${korisnik.korisnicko_ime}"><br>
		<input type="hidden" name="korisnicko_ime" value="${korisnik.korisnicko_ime}">
		
		<label for="lozinka1">Trenutna Lozinka: </label>
		<input required="required" type="password" name="lozinka1"  value="${korisnik.lozinka}"><br>
		
		<label for="lozinka2">Nova lozinka: </label>
		<input required="required" type="password" name="lozinka2" value="${korisnik.lozinka}"><br>
		
		<input type="submit" value="Izmeni">
		<input type="hidden" name="akcija" value="izmeniKorisnickeDetalje">
	</form>
	
</body>
</html>

<%}else {
	String url = request.getRequestURL().toString();
	response.sendRedirect("prijava.jsp"); 
}
%>