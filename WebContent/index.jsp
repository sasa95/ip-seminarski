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
		
		<input type="submit" value="trazi" name="akcija">
	</form>
</body>
</html>