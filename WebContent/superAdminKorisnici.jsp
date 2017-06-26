<%@page import="rs.Korisnik"%>
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
	ArrayList<Korisnik>lskor = (ArrayList<Korisnik>)request.getAttribute("lskor");
	ArrayList<Hotel>lshotid = (ArrayList<Hotel>)request.getAttribute("lshotid");
	Korisnik korisnik = (Korisnik)superAdminSesija.getAttribute("korisnik");
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
	<h1>Pregled svih korisnika</h1>
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
			<th></th>
		<tr>
		<%for(Korisnik k:lskor){%>
			<tr>
				<td><%=k.getIme()%></td>
				<td><%=k.getPrezime()%></td>
				<td><%=k.getBroj_licne_karte()%></td>
				<td><%=k.getAdresa()%></td>
				<td><%=k.getEmail()%></td>
				<td><%=k.getKorisnicko_ime()%></td>
				<td><%=k.getTip_korisnika()%></td>
				<td><%if(k.getTip_korisnika().equals("admin_hotela")){out.println("<a href=\"administrator?akcija=izmeniKorisnika&user="+k.getKorisnicko_ime()+"\">Izmeni</a>");}%></td>
				<td><a href="administrator?akcija=obrisiKorisnika&user=<%=k.getKorisnicko_ime()%>">Obriši</a></td>
			</tr>
		<%} %>
		
	</table>
		<%
		if(status!=null){
			if(status.equals("okI")){
				out.println("<h3>Uspešan unos korisnika!</h3>");
			}
			
			else if(status.equals("okD")){
				out.println("<h3>Uspešno obrisan korisnik!</h3>");
			}
			
			else if(status.equals("okU")){
				out.println("<h3>Uspešno izmenjen korisnik!</h3>");
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
		<label for="broj_licne_karte">Broj lične karte: </label>
		<input id="broj_licne_karte" type="number" min="100000000" max="999999999" placeholder="Npr. 001234567" name="broj_licne_karte" required="required" value="${korisnik.broj_licne_karte}"><br>
		
		<label for="ime">Ime: </label>
		<input id="ime" type="text" placeholder="Npr. Petar" name="ime" required="required" value="${korisnik.ime}"><br>
		
		<label for="prezime">Prezime: </label>
		<input id="prezime" type="text" placeholder="Npr. Petrović" name="prezime" required="required" value="${korisnik.prezime}"><br>
		
		<label for="adresa">Adresa: </label>
		<input id="adresa" type="text" placeholder="Npr. Svetog Save 66, Čačak" name="adresa" required="required" value="${korisnik.adresa}"><br>
		
		<label for="email">Email: </label>
		<input id="email" type="email" placeholder="Npr. petarpetrovic95@gmail.com" name="email" required="required" value="${korisnik.email}"><br>
		
		<label for="korisnicko_ime">Korisničko ime: </label>
		<input disabled="disabled" id="korisnicko_ime" type="text" placeholder="Npr. petar_petrovic" name="korisnicko_ime" required="required" value="${korisnik.korisnicko_ime}">
		<input id="korisnicko_ime" type="hidden" placeholder="Npr. petar_petrovic" name="korisnicko_ime" required="required" value="${korisnik.korisnicko_ime}"><br>
		
		<label for="lozinka">Lozinka: </label>
		<input id="lozinka" type="password" name="lozinka" required="required" value="${korisnik.lozinka}"><br>
		
		<label for="hotelID">Hotel</label>
		<select name="hotelID" id="hotelID">
			<option value=""></option>
			<% for(Hotel pom:lshotid){ %>
				<option value="<%=pom.getHotelID()%>" <%if(korisnik!=null && korisnik.getHotelID()==pom.getHotelID()){out.println("selected");}%>><%=pom.getNaziv()%></option>
			<%} %>
		</select>
	
			<%if(korisnik==null){%>
				<input type="hidden" name="akcija" value="unosKorisnika">
				<input type="submit" value="Unesi">
			<%} else {%>
				<input type="hidden" name="akcija" value="izmenaKorisnika">
				<input type="hidden" name="user" value="${korisnik.korisnicko_ime}">
				<input type="submit" value="Izmeni">
			<%} %>			
			
	</form>

</body>
</html>
<%}else { response.sendRedirect("prijava.jsp");}%>