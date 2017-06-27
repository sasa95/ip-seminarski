<%@page import="rs.Hotel_Rezervacija_UslugaDATE"%>
<%@page import="rs.Hotel_Rezervacija_Usluga"%>
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
	ArrayList<Hotel_Rezervacija_UslugaDATE>lsrez = (ArrayList<Hotel_Rezervacija_UslugaDATE>)request.getAttribute("lsrez");
	ArrayList<Hotel>lsh = (ArrayList<Hotel>)request.getAttribute("lsh");
	String hotelID = request.getParameter("hotelID");
	int hot_id=0;
	if(hotelID!=null){
		hot_id = Integer.parseInt(hotelID);
	}
	
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
	<form action="administrator" method="get">
		<label for="hotelID">Hotel</label>
		<select name="hotelID" id="hotelID">
			<option value="0"></option>
			<%for(Hotel hot:lsh){ %>
				<option value="<%=hot.getHotelID()%>" <%if(hot.getHotelID()==hot_id){out.println("selected");}%>><%=hot.getNaziv()%></option>
			<%} %>
		</select>
		<input type="hidden" name="akcija" value="rezervacijeByHotelID">
		<input type="submit" value="Traži">
	</form>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>Hotel</th>
			<th>Datum prijave</th>
			<th>Datum odlaska</th>
			<th>Lična karta</th>
			<th>Soba</th>
			<th>Usluga</th>
		</tr>
		<c:forEach var="rez" items="${lsrez}">
			<tr>
				<td>${rez.rezervacijaID}</td>
				<td>${rez.naziv}</td>
				<td>${rez.datum_prijavljivanja}</td>
				<td>${rez.datum_odlaska}</td>
				<td>${rez.broj_licne_karte}</td>
				<td>${rez.sobaID}</td>
				<td>${rez.vrsta_usluge}</td>
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
</body>
</html>
<%}else { response.sendRedirect("prijava.jsp");}%>