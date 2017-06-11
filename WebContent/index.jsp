<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>  
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Index</title>
</head>
<body>
${msg }
	<form action="Servlet" method="get">
		<input type="search" name="pretraga" placeholder="Trazite hotel..."><br>
		
		<span class="kategorija-broj">1</span><input type="checkbox" name="kategorija" value="1" checked="checked">
		<span class="kategorija-broj">2</span><input type="checkbox" name="kategorija" value="2" checked="checked">
		<span class="kategorija-broj">3</span><input type="checkbox" name="kategorija" value="3" checked="checked">
		<span class="kategorija-broj">4</span><input type="checkbox" name="kategorija" value="4" checked="checked">
		<span class="kategorija-broj">5</span><input type="checkbox" name="kategorija" value="5" checked="checked"><br>
		
		<label for="grad">Grad:</label>
		<input type="text" name="adresa" id="grad"><br>
		
		<label for="broj_kreveta">Vrste aktivnosti:</label>
		<select name="broj_kreveta" id="broj_kreveta">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
		</select>
		
		<input type="submit" value="trazi" name="akcija">
	</form>
</body>
</html>