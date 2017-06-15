<%@page import="rs.Usluga"%>
<%@page import="rs.Tip_sobe"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@page import="rs.Korisnik"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Rezervacija</title>
</head>
<body>
	<%
		HttpSession loginSesija = request.getSession();
		String hotelID = request.getParameter("hotelID");
		
		// OD RANIJE
		
		String parametri = "hotelID="+hotelID;
		loginSesija.setAttribute("parametri", parametri);
		
		//
		
		String username = (String)loginSesija.getAttribute("username");
		Korisnik kor = (Korisnik)loginSesija.getAttribute("kor");
		
		System.out.println(kor);
		
		ArrayList<Usluga>lsusl = (ArrayList<Usluga>)loginSesija.getAttribute("lsusl");
		ArrayList<Tip_sobe>lsts = (ArrayList<Tip_sobe>)loginSesija.getAttribute("lsts");
		
		
		
		if(username!=null){
	%>
	<h1>${msg }</h1>
	<h2>Popunite formu za rezervaciju</h2>
	
	<form method="post" action="Servlet_rezervacija?akcija=Rezervisi&hotelID=<%=hotelID%>">
		<label for="datum_prijavljivanja">Datum prijavljivanja:</label>
		<input type="date" required="required" name="datum_prijavljivanja" id="datum_prijavljivanja" placeholder="Npr. 2017-01-31" value="${param.datum_prijavljivanja}"><br>
		
		<label for="datum_odlaska">Datum odlaska (opciono):</label>
		<input type="date" name="datum_odlaska" id="datum_odlaska" placeholder="Npr. 2017-02-31" value="${param.datum_odlaska}"><br>
		
		<label for="uslugaID">Vrsta usluge:</label>
		<select name="uslugaID" id="uslugaID">
			<%
				for(Usluga usluga:lsusl){
			%>
			<option value="<%=usluga.getUslugaID()%>"><%=usluga.getVrsta_usluge()%></option>
			<%} %>
		</select><br>
		
		<label for="tip_sobe">Tip sobe:</label>
		<select name="tip_sobe" id="tip_sobe">
			<%
				for(Tip_sobe ts:lsts){
			%>
			<option value="<%=ts.getNaziv()%>"><%=ts.getNaziv()%></option>
			<%} %>
		</select><br>
		
		<label for="broj_licne_karte">Lična karta:</label>
		<input type="number" name="broj_licne_karte" disabled="disabled" value="<%=kor.getBroj_licne_karte()%>"><br>
		
		<label for="ime">Ime:</label>
		<input type="text" name="ime" disabled="disabled" value="${kor.ime}"><br>
		
		<label for="prezime">Prezime:</label>
		<input type="text" name="prezime" disabled="disabled" value="${kor.prezime}"><br>
		
		<label for="adresa">Adresa:</label>
		<input type="text" name="adresa" disabled="disabled" value="${kor.adresa}"><br>
		
		<label for="email">Email:</label>
		<input type="email" name="email" disabled="disabled" value="${kor.email}"><br>
		
		<input type="hidden" name="broj_licne_karte" value="<%=kor.getBroj_licne_karte()%>"><br>
		
		<input type="submit" name="akcija" value="Rezervisi">
	</form>
	
	<%}else {
			String url = request.getRequestURL().toString();
			response.sendRedirect("prijava.jsp"); 
		}
	%>
</body>
</html>