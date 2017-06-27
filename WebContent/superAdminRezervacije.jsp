<%@page import="rs.Rezervacija"%>
<%@page import="rs.Hotel"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
     
<%

	HttpSession superAdminSesija = request.getSession();
	String adminUsername = (String)superAdminSesija.getAttribute("adminUsername");
	ArrayList<Rezervacija>lsrez = (ArrayList<Rezervacija>)request.getAttribute("lsrez");
	String msg = request.getParameter("msg");
	Hotel hotel = (Hotel)superAdminSesija.getAttribute("hotel");
	
	String status = request.getParameter("status");
	if(adminUsername!=null && !adminUsername.equals("")){
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
</head>
<body>
	<h1>Pregled rezervacija</h1>
	<table border="1">
		<tr>
			<th>Datum prijave</th>
			<th>Datum odlaska</th>
			<th>Lična karta</th>
			<th>Hotel</th>
			<th>Usluga</th>
			<th>Opis</th>
			<th></th>
			<th></th>
		</tr>
		<c:forEach var="hot" items="${lshoteli}">
			<tr>
				<td>${hot.hotelID}</td>
				<td>${hot.naziv}</td>
				<td>${hot.adresa}</td>
				<td>${hot.kategorija}</td>
				<td>${hot.broj_lezaja}</td>
				<td>${hot.opis}</td>
				<td><a href="administrator?akcija=izmeniHotel&hotelID=${hot.hotelID}">Izmeni</a></td>
				<td><a href="administrator?akcija=obrisiHotel&hotelID=${hot.hotelID}">Obriši</a></td>
			</tr>
		</c:forEach>
	</table>
		<%
		if(status!=null){
			if(status.equals("okI")){
				out.println("<h3>Uspešan unos hotela!</h3>");
			}
			
			else if(status.equals("okD")){
				out.println("<h3>Uspešno obrisan hotel!</h3>");
			}
			
			else if(status.equals("okU")){
				out.println("<h3>Uspešno izmenjen hotel!</h3>");
			}
			
			else if(status.equals("empty")){
				out.println("<h3>Morate popuniti sva polja</h3>");
			}
			
			else if(status.equals("format")){
				out.println("<h3>Neispravan format unosa!</h3>");
			}
		}
		%>
	<form action="administrator" method="post">
		<label for="naziv">Naziv:</label>
		<input type="text" id="naziv" name="naziv" value="${hotel.naziv}"><br>
		
		<label for="adresa">Adresa:</label>
		<input type="text" id="adresa" name="adresa" value="${hotel.adresa}"><br>
		
		<label for="kategorija">Kategorija:</label>
		<select name="kategorija" id="kategorija">
			<option value="1" <%if(hotel!=null && hotel.getKategorija()==1){out.println("selected");}%>>1</option>
			<option value="2" <%if(hotel!=null && hotel.getKategorija()==2){out.println("selected");}%>>2</option>
			<option value="3" <%if(hotel!=null && hotel.getKategorija()==3){out.println("selected");}%>>3</option>
			<option value="4" <%if(hotel!=null && hotel.getKategorija()==4){out.println("selected");}%>>4</option>
			<option value="5" <%if(hotel!=null && hotel.getKategorija()==5){out.println("selected");}%>>5</option>
		</select><br>
		
		
		<label for="broj_lezaja">Broj lezaja:</label>
		<input type="text" id="broj_lezaja" name="broj_lezaja" value="${hotel.broj_lezaja}"><br>
		
		<label for="opis">Opis:</label>
		<textarea rows="5" cols="50" name="opis">${hotel.opis}</textarea><br>
		
		<%if(hotel==null){%>
			<input type="hidden" name="akcija" value="unosHotela">
			<input type="submit" value="Unesi">
		<%} else {%>
			<input type="hidden" name="akcija" value="izmenaHotela">
			<input type="hidden" name="hotelID" value="${hotel.hotelID}">
			<input type="submit" value="Izmeni">
		<%} %>
	</form>

</body>
</html>
<%}else { response.sendRedirect("prijava.jsp");}%>