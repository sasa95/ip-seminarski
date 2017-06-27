<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="rs.Hotel"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lista hotela</title>

</head>
	<%		
		ArrayList<Hotel>hotel = (ArrayList<Hotel>)request.getAttribute("hotel");
		String [] kat = request.getParameterValues("kategorija");
		String nazivHotela = request.getParameter("pretraga");
		String grad = request.getParameter("adresa");
		String naziv_vrste_aktivnosti = request.getParameter("naziv_vrste_aktivnosti");
		String vrsta_usluge = request.getParameter("vrsta_usluge");
		if(hotel.size()>0 && hotel!=null){
	%>
<body>
	<h1>Rezultati pretrage za:</h1>
	<%if(!nazivHotela.equals("")){ %>
		<p>Naziv hotela: <%=nazivHotela %></p>
	<%} %>
	<p>Kategorije: 
		<%
			for(int i=0;i<kat.length;i++)
				out.println(kat[i]);
		%>
	</p>
	<%if(!grad.equals("")){ %>
		<p>Mesto: <%=grad %></p>
	<%} %>
	<%if(!naziv_vrste_aktivnosti.equals("")){ %>
		<p>Vrsta aktivnosti: <%=naziv_vrste_aktivnosti %></p>
	<%} %>
	<%if(!vrsta_usluge.equals("")){ %>
		<p>Vrsta usluge: <%=vrsta_usluge %></p>
	<%} %>
		<c:forEach var="pom" items="${hotel}">	
			<ul>
				<li><img src="img/hoteli/${pom.hotelID}.jpg"/></li>
				<li>Naziv: ${pom.naziv}</li>
				<li>Adresa: ${pom.adresa}</li>
				<li>Kategorija: ${pom.kategorija}</li>
				<li>Broj ležaja: ${pom.broj_lezaja}</li>	
			</ul>
			<a href="Servlet?id=${pom.hotelID}&akcija=jedanHotel">Detalji</a><br><br>
		</c:forEach>
	<%
		}else {
			request.setAttribute("msg", "Nema rezultata koji odgovaraju unosu.");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	%>
</body>
</html>