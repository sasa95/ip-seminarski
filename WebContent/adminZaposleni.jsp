<%@page import="rs.Rukovodilac"%>
<%@page import="rs.Zaposleni_posao"%>
<%@page import="rs.Posao"%>
<%@page import="rs.Zaposleni"%>
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
	String msg = request.getParameter("msg");
	Hotel hotel = (Hotel)request.getAttribute("hotel");
	ArrayList<Zaposleni_posao>lszap = (ArrayList<Zaposleni_posao>)request.getAttribute("lszap");
	ArrayList<Posao>lsp = (ArrayList<Posao>)request.getAttribute("lsp");
	ArrayList<Rukovodilac>lsruk = (ArrayList<Rukovodilac>)request.getAttribute("lsruk");
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
	<h1>Zaposleni hotela ${hotel.naziv}</h1>
	<table border=1>
		<tr>
			<th>ID</th>
			<th>Ime</th>
			<th>Prezime</th>
			<th>Plata</th>
			<th>Posao</th>
			<th>Rukovodilac</th>
			<th></th>
		<tr>
		<c:forEach var="pom" items="${lszap}">
			<tr>
				<td>${pom.zaposleniID}</td>
				<td>${pom.ime}</td>
				<td>${pom.prezime}</td>
				<td>${pom.plata}</td>
				<td>${pom.naziv_posla}</td>
				<td>${pom.imeRuk} ${pom.prezimeRuk}</td>
				<td><a href="Servlet_admin?akcija=obrisiZaposlenog&zaposleniID=${pom.zaposleniID}">Izbriši</a></td>
			</tr>
		</c:forEach>
	</table>
	
	<h2><%if(msg!=null){out.println(msg);}%></h2>
	
	<form action="Servlet_admin" method="POST">
		<label for="ime">Ime</label>
		<input type="text" name="ime" id="ime"><br>
		<label for="prezime">Prezime</label>
		<input type="text" name="prezime" id="prezime"><br>
		<label for="plata">Plata</label>
		<input type="text" name="plata" id="plata"><br>
		<label for="posao">Posao</label>
		<select name="posaoID" id="posaoID">
			<c:forEach var="pos" items="${lsp}">
				<option value="${pos.posaoID}">${pos.naziv_posla}</option>
			</c:forEach>
		</select><br>
		<label for="rukovodilacID">Rukovodilac</label>
		<select name="rukovodilacID" id="rukovodilacID">
			<option value=""></option>
			<c:forEach var="ruk" items="${lsruk}">
				<option value="${ruk.rukovodilacID}">${ruk.ime} ${ruk.prezime}</option>
			</c:forEach>
		</select><br>
		<input type="hidden" name="akcija" value="unosZaposlenog">
		<input type="submit" value="Unesi">
	</form>	
	<%
		if(status!=null){
			if(status.equals("okI")){
				out.println("<h3>Uspešan unos zaposlenog</h3>");
			}
			
			if(status.equals("okD")){
				out.println("<h3>Uspešno brisanje zaposlenog</h3>");
			}
		}
	%>
</body>
</html>
<%}else { response.sendRedirect("prijava.jsp");}%>