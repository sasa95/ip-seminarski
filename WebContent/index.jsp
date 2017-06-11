<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>  
    
<%
	DAO dao = new DAO();
	ArrayList<Vrsta_aktivnosti>va = new ArrayList<Vrsta_aktivnosti>();
	va = dao.getVrsteAktivnosti();
%>    
    
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
		
		<label for="naziv_vrste_aktivnosti">Vrste aktivnosti:</label>
		
		<select name="naziv_vrste_aktivnosti" id="naziv_vrste_aktivnosti">
			<option selected="selected"></option>
			<%
				for(Vrsta_aktivnosti pom:va){
			%>
				<option value="<%=pom.getNaziv_vrste_aktivnosti()%>"><%=pom.getNaziv_vrste_aktivnosti()%></option>
			<%} %>
		
		</select><br>
		
		<input type="submit" value="trazi" name="akcija">
	</form>
</body>
</html>