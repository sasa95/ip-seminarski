<%@page import="rs.Korisnici_aktivnosti"%>
<%@page import="rs.Vrsta_aktivnostiAktivnost"%>
<%@page import="rs.Korisnik"%>
<%@page import="rs.Hotel_aktivnost"%>
<%@page import="rs.Hotel"%>
<%@page import="rs.Hotel_aktivnost"%>
<%@page import="rs.Aktivnost"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="rs.Trzni_centar"%>
<%@page import="rs.Trzni_centar_prodavnica"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Detalji aktivnosti</title>
</head>
<body>
<%
	Hotel h = (Hotel)request.getAttribute("h");
	Vrsta_aktivnosti nazivAktivnosti = (Vrsta_aktivnosti)request.getAttribute("nazivAktivnosti");
	ArrayList<Hotel_aktivnost>lsakt = (ArrayList<Hotel_aktivnost>)request.getAttribute("lsakt");
	ArrayList<Vrsta_aktivnostiAktivnost>lsaktivnost=(ArrayList<Vrsta_aktivnostiAktivnost>)request.getAttribute("lsaktivnost");
	ArrayList<Korisnici_aktivnosti> ka = (ArrayList<Korisnici_aktivnosti>)request.getAttribute("ka");
	HttpSession loginSesija = request.getSession();
	Korisnik kor = (Korisnik)loginSesija.getAttribute("kor");
	
	String aktivnostID = request.getParameter("aktivnostID");
	String hotelID = request.getParameter("hotelID");
	String returnString = "Servlet?akcija=AktivnostDetalji&aktivnostID="+aktivnostID+"&hotelID="+hotelID;
	
	loginSesija.setAttribute("returnString",returnString);
%>

	<h1>${nazivAktivnosti.naziv_vrste_aktivnosti }</h1>

	<h2>Detalji</h2>
	
	<%for(Hotel_aktivnost pom:lsakt){ %>
		<h3>Naziv aktivnosti: <%=pom.getNaziv()%></h3>
		<p>Opis: <%=pom.getOpis()%></p>
		<p>Mesto:<%=pom.getMesto_odrzavanja()%></p>
		<p>Datum:<%=pom.getDatum_odrzavanja()%></p>
		<p>Vreme:<%=pom.getVreme_odrzavanja()%></p>
		
		<%
			if(ka!=null){ 
				boolean mark = false;
				for(Korisnici_aktivnosti pomka:ka){
					if(pomka.getAktivnostiID()==pom.getAktivnostID()){
						out.println("obelezeno");
						mark=true;
					}
					
				}
				if(mark==false){
					out.println("<a href=\"Servlet_profil?akcija=zanimljivo&akt="+pom.getAktivnostID()+"\">Zanima me</a>");
				}
			}
		
			else {
				out.println("<a href=\"Servlet_profil?akcija=zanimljivo&akt="+pom.getAktivnostID()+"\">Zanima me</a>");
			}
			
			
		%>
		
	<%} %>

	
	
	
	
	
</body>
