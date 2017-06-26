<%@page import="rs.Rukovodilac"%>
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
	ArrayList<Rukovodilac>lsruk = (ArrayList<Rukovodilac>)request.getAttribute("lsruk");
	Rukovodilac rukovodilac = (Rukovodilac)adminSesija.getAttribute("rukovodilac");
	String status = request.getParameter("status");
	String msg = request.getParameter("msg");
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
	<h1>Rukovodioci hotela ${hotel.naziv}</h1>
	<table border=1>
		<tr>
			<th>ID</th>
			<th>Ime</th>
			<th>Prezme</th>
			<th>Plata</th>
			<th></th>
			<th></th>
		<tr>
		<c:forEach var="pom" items="${lsruk}">
			<tr>
				<td>${pom.rukovodilacID}</td>
				<td>${pom.ime}</td>
				<td>${pom.prezime}</td>
				<td>${pom.plata}</td>
				<td><a href="Servlet_admin?akcija=obrisiRukovodioca&rukID=${pom.rukovodilacID}&hotelID=<%=hot_id%>">Obriši</a></td>
				<td><a href="Servlet_admin?akcija=izmeniRukovodioca&rukID=${pom.rukovodilacID}&hotelID=<%=hot_id%>">Izmeni</a></td>
			</tr>
		</c:forEach>
	</table>
	
	<%if(msg!=null && !msg.equals("")){ 
		out.print("<h2>"+msg+"</h2>");
	}%>
	
	<form action="Servlet_admin" method="POST">
		<label for="ime">Ime</label>
		<input type="text" name="ime" id="ime" value="${rukovodilac.ime}"><br>
		<label for="prezime">Prezime</label>
		<input type="text" name="prezime" id="prezime" value="${rukovodilac.prezime}"><br>
		<label for="plata">Plata</label>
		<input type="text" name="plata" id="plata" value="${rukovodilac.plata}"><br>
		
		
		<%if(rukovodilac==null){ %>
			<input type="hidden" name="akcija" value="unosRukovodioca">
			<input type="submit" value="Unesi">
		<%} else{ %>
			<input type="hidden" name="akcija" value="izmenaRukovodioca">
			<input type="hidden" name="rukovodilacID" value="<%=rukovodilac.getRukovodilacID()%>">
			<input type="submit" value="Izmeni">
		<%} %>
	</form>	
	
	<% if(status!=null){
		if(status.equals("okI")){
			out.println("<h3>Uspešan unos rukovodioca</h3>");
		}
		
		else if(status.equals("okD")){
			out.println("<h3>Uspešno brisanje rukovodioca</h3>");
		}
		
		else if(status.equals("okU")){
			out.println("<h3>Uspešno ažuriranje rukovodioca</h3>");
		}
		
		else if(status.equals("empty")){
			out.println("<h3>Uspešno ažuriranje rukovodioca</h3>");
		}
		
		else if(status.equals("okU")){
			out.println("<h3>Uspešno ažuriranje rukovodioca</h3>");
		}
	}%>
</body>
</html>
<%}else { response.sendRedirect("prijava.jsp");}%>