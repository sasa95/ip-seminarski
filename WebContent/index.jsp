<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<%
	HttpSession loginSesija = request.getSession();
	String username = (String)loginSesija.getAttribute("username");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
</head>
<body>
${msg }
	<form action="Servlet" method="get">
		<input type="search" name="pretraga" placeholder="Trazite hotel..."><br>
		<span>Kategorije</span>
		<span class="kategorija-broj">1</span><input type="checkbox" name="kategorija" value="1" checked="checked">
		<span class="kategorija-broj">2</span><input type="checkbox" name="kategorija" value="2" checked="checked">
		<span class="kategorija-broj">3</span><input type="checkbox" name="kategorija" value="3" checked="checked">
		<span class="kategorija-broj">4</span><input type="checkbox" name="kategorija" value="4" checked="checked">
		<span class="kategorija-broj">5</span><input type="checkbox" name="kategorija" value="5" checked="checked"><br>
		
		<label for="grad">Grad:</label>
		<input type="text" name="adresa" id="grad"><br>
		
		<label for="naziv_vrste_aktivnosti">Vrste aktivnosti:</label>
		<select name="naziv_vrste_aktivnosti" id="naziv_vrste_aktivnosti">
			<option selected="selected" value="">Sve</option>
				<option value="Sport">Sport</option>
				<option value="Kultura">Kultura</option>
				<option value="Religija">Religija</option>
				<option value="Zabava">Zabava</option>
				<option value="Edukacija">Edukacija</option>
		</select><br>
		
		<label for="vrsta_usluge">Vrsta usluge:</label>
		<select name="vrsta_usluge" id="vrsta_usluge">
			<option selected="selected" value="">Sve</option>
			<option value="pansion">Pansion</option>
			<option value="polu-pansion">Polu-pansion</option>
			<option value="full-pansion">Full-pansion</option>	
		</select><br>
		
		
		
		<input type="submit" value="Traži" name="akcija"><br><br>
		<a href="registracija.jsp">Registracija</a><br>
		<%if(username==null){ %>
		<a href="prijava.jsp">Prijava</a>
		<%} else { %>
		<a href="Servlet_sesija?akcija=logout">Odjava</a>
		<%} %>
		
	</form>
</body>
</html>