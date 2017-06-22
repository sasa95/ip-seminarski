<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
     
<%
	HttpSession adminSesija = request.getSession();
	String adminUsername = (String)adminSesija.getAttribute("adminUsername");
	
	String hotelID = request.getParameter("hotelID");
	//Uzima se ID iz sesije
	int hot_id = (Integer)adminSesija.getAttribute("hot_id");
	if(adminUsername!=null && !adminUsername.equals("")){
		//Zabraniti adminu da menja druge hotele proverom ID iz URL-a i ID-a iz sesije
		if(Integer.parseInt(hotelID)==hot_id){
%>    
     
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Index</title>
</head>
<body>
	<h1>Dobrodošli, admineee</h1>
	
	<ul>
		<li><a href="Servlet_admin?akcija=hotelDetalji&hotelID=<%=hotelID%>">Detalji hotela</a></li>
	</ul>
	
	<a href="Servlet_admin?akcija=logout">Odjava</a><br>
</body>
</html>
<%}else response.sendRedirect("indexAdmin.jsp?hotelID="+hot_id); %>
<%}else { response.sendRedirect("prijava.jsp");}%>