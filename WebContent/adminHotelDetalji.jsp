<%@page import="rs.Hotel"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
     
<%

	HttpSession adminSesija = request.getSession();
	String adminUsername = (String)adminSesija.getAttribute("adminUsername");
	
	String hotelID = request.getParameter("hotelID");
	
	
	Hotel hotel = (Hotel)request.getAttribute("hotel");
	
	String status = request.getParameter("status");
	
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
	<h1>Izmenite detalje hotela ${hotel.naziv}</h1>
	<form action="Servlet_admin?akcija=izmeniHotel" method="post">
		<label for="naziv">Naziv:</label>
		<input type="text" id="naziv" name="naziv" value="${hotel.naziv}"><br>
		
		<label for="adresa">Adresa:</label>
		<input type="text" id="adresa" name="adresa" value="${hotel.adresa}"><br>
		
		<label for="kategorija">Kategorija:</label>
		<select name="kategorija" id="kategorija">
			<option value="1" <%if(hotel.getKategorija()==1){out.println("selected");}%>>1</option>
			<option value="2" <%if(hotel.getKategorija()==2){out.println("selected");}%>>2</option>
			<option value="3" <%if(hotel.getKategorija()==3){out.println("selected");}%>>3</option>
			<option value="4" <%if(hotel.getKategorija()==4){out.println("selected");}%>>4</option>
			<option value="5" <%if(hotel.getKategorija()==5){out.println("selected");}%>>5</option>
		</select><br>
		
		<label for="broj_lezaja">Broj lezaja:</label>
		<input type="text" id="broj_lezaja" name="broj_lezaja" value="${hotel.broj_lezaja}"><br>
		
		<label for="opis">Opis:</label>
		<textarea rows="5" cols="50" name="opis">${hotel.opis}</textarea><br>
		
		<input type="hidden" name="hotelID" value="<%=hotelID%>">
		<input type="hidden" name="returnPath" value="Servlet_admin?akcija=hotelDetalji&hotelID=<%=hotelID%>">
		<input type="submit" value="Izmeni">
	</form>
	<%if(status!=null && status.equals("ok")){ %>
		<h3>Uspešna izmena</h3>
	<%} %>
</body>
</html>
<%}else response.sendRedirect("indexAdmin.jsp?hotelID="+hot_id); %>
<%}else { response.sendRedirect("prijava.jsp");}%>