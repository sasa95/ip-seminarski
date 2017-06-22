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
	
	ArrayList<Korisnik>korisnici = (ArrayList<Korisnik>)request.getAttribute("korisnici");
	String hotelID = request.getParameter("hotelID");
	
	if(adminUsername!=null && !adminUsername.equals("")){
		//Zabraniti adminu da menja druge hotele proverom ID iz URL-a i ID-a iz sesije
		int hot_id = (Integer)adminSesija.getAttribute("hot_id");
		if(Integer.parseInt(hotelID)==hot_id){
%>    
     
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
</head>
<body>
	<h1>Korisnici hotela ${hotel.naziv}</h1>
	<table border=1>
		<tr>
			<th>Ime</th>
			<th>Prezme</th>
			<th>Broj lične karte</th>
			<th>Adresa</th>
			<th>Email</th>
			<th>Korisnicko ime</th>
			<th>Tip korisnika</th>
			<th></th>
		<tr>
		<c:forEach var="pom" items="${korisnici}">
			<tr>
				<td>${pom.ime}</td>
				<td>${pom.prezime}</td>
				<td>${pom.broj_licne_karte}</td>
				<td>${pom.adresa}</td>
				<td>${pom.email}</td>
				<td>${pom.korisnicko_ime}</td>
				<td>${pom.tip_korisnika}</td>
				<td><a href="Servlet_admin?akcija=obrisiKorisnika&user=${pom.korisnicko_ime}&hotelID=<%=hotelID%>">Obriši</a></td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>
<%}else response.sendRedirect("indexAdmin.jsp?hotelID="+hot_id); %>
<%}else { response.sendRedirect("prijava.jsp");}%>