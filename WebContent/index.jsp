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
		<input type="submit" value="trazi" name="akcija">
	</form>
</body>
</html>