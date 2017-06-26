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
	ArrayList<Hotel>lshoteli = (ArrayList<Hotel>)request.getAttribute("lshoteli");
	String msg = request.getParameter("msg");
	
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
	<h1>Pregled svih hotela</h1>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>Naziv</th>
			<th>Adresa</th>
			<th>Kategorija</th>
			<th>Broj ležaja</th>
			<th>Opis</th>
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
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
		</select><br>
		
		
		<label for="broj_lezaja">Broj lezaja:</label>
		<input type="text" id="broj_lezaja" name="broj_lezaja" value="${hotel.broj_lezaja}"><br>
		
		<label for="opis">Opis:</label>
		<textarea rows="5" cols="50" name="opis">${hotel.opis}</textarea><br>
		
		<input type="hidden" name="akcija" value="unosHotela">
		<input type="submit" value="Unesi">
	</form>

</body>
</html>
<%}else { response.sendRedirect("prijava.jsp");}%>