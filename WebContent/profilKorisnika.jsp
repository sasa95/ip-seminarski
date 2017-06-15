<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<%
	HttpSession loginSesija = request.getSession();
	String username = (String)loginSesija.getAttribute("username");
	if(username!=null){
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
</head>
<body>
${msg }
	
	
	
	
	
</body>
</html>

<%}else {
	String url = request.getRequestURL().toString();
	response.sendRedirect("prijava.jsp"); 
}
%>