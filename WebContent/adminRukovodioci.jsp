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
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Rukovodioci</title>
	<!-- Font -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <!-- Custom styles -->
    <link href="css/main.css" rel="stylesheet">
</head>
<body class="admin-body">
	<div id="wrapper">
		<div id="header">
			<nav class="navbar navbar-toggleable-md navbar-light bg-faded" id="nav--main">
				<div class="container">
					<button class="navbar-toggler navbar-toggler-right collapsed" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
					</button>
					<a class="navbar-brand" href="indexAdmin.jsp"><img class="img-fluid" src="img/logo.png" alt=""></a>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav float-lg-right text-center">
						<li class="nav-item"><a class="nav-link" href="Servlet_admin?akcija=hotelDetalji&hotelID=<%=hot_id%>">Detalji hotela</a></li>
						<li class="nav-item"><a class="nav-link" href="Servlet_admin?akcija=korisniciTabela&hotelID=<%=hot_id%>">Korisnici</a></li>
				  		<li class="nav-item"><a class="nav-link" href="Servlet_admin?akcija=rezervacijeTabela&hotelID=<%=hot_id%>">Rezervacije</a></li>
				  		<li class="nav-item"><a class="nav-link" href="Servlet_admin?akcija=zaposleniTabela&hotelID=<%=hot_id%>">Zaposleni</a></li>
				 		<li class="nav-item"><a class="nav-link" href="Servlet_admin?akcija=rukovodiociTabela&hotelID=<%=hot_id%>">Rukovodioci</a></li>
							<li class="nav-item dropdown">
							    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><%if(adminUsername!=null){%><img src="img/korisnici/<%=adminUsername%>.jpg"><%} %>Profil</a>
							    <div class="dropdown-menu">
									<a href="Servlet_admin?akcija=logout" class="dropdown-item">Odjava</a>
							    </div>
							</li>
						</ul>
					</div>		
				</div>
			</nav>
		</div><!-- #header -->

		<div id="content">
			<div class="container admin-table-container">
			<h3 class="msg msg--error text-center"><%if(msg!=null){out.println(msg);}%></h3>
			<% if(status!=null){
				if(status.equals("okI")){
					out.println("<h3 class=\"msg msg--success text-center\">Uspešan unos rukovodioca</h3>");
				}
				
				else if(status.equals("okD")){
					out.println("<h3 class=\"msg msg--success text-center\">Uspešno brisanje rukovodioca</h3>");
				}
				
				else if(status.equals("okU")){
					out.println("<h3 class=\"msg msg--success text-center\">Uspešno ažuriranje rukovodioca</h3>");
				}
				
				else if(status.equals("empty")){
					out.println("<h3 class=\"msg msg--success text-center\">Uspešno ažuriranje rukovodioca</h3>");
				}
				
				else if(status.equals("okU")){
					out.println("<h3 class=\"msg msg--success text-center\">Uspešno ažuriranje rukovodioca</h3>");
				}
			}%>
				<table class="admin-table" border=1>
				<caption>Rukovodioci hotela ${hotel.naziv}</caption>
					<tr>
						<th>ID</th>
						<th>Ime</th>
						<th>Prezme</th>
						<th>Plata</th>
						<th colspan="2" class="text-center">Akcija</th>
					</tr>
					<c:forEach var="pom" items="${lsruk}">
						<tr>
							<td>${pom.rukovodilacID}</td>
							<td>${pom.ime}</td>
							<td>${pom.prezime}</td>
							<td>${pom.plata}</td>
							<td><a class="delete-record" href="Servlet_admin?akcija=obrisiRukovodioca&rukID=${pom.rukovodilacID}&hotelID=<%=hot_id%>">Obriši</a></td>
							<td><a class="edit-record" href="Servlet_admin?akcija=izmeniRukovodioca&rukID=${pom.rukovodilacID}&hotelID=<%=hot_id%>">Izmeni</a></td>
						</tr>
					</c:forEach>
				</table>
		
			</div>
			<div class="admin-form-container">
				<%if(msg!=null && !msg.equals("")){ 
					out.print("<h3 class=\"msg msg--error text-center\">"+msg+"</h3>");
				}%>
				<form action="Servlet_admin" method="post">
					<div class="form-group row">
					  <label for="ime" class="col-4 col-form-label">Ime</label>
					  <div class="col-8">
					    <input required="required" class="form-control" type="text" value="${rukovodilac.ime}" id="ime" name="ime" placeholder="Npr. Petar">
					  </div>
					</div>
						
					<div class="form-group row">
					  <label for="prezime" class="col-4 col-form-label">Prezime</label>
					  <div class="col-8">
					    <input required="required" class="form-control" type="text" value="${rukovodilac.prezime}" id="prezime" name="prezime" placeholder="Npr. Petrović">
					  </div>
					</div>

					<div class="form-group row">
					  <label for="plata" class="col-4 col-form-label">Plata</label>
					  <div class="col-8">
					    <input required="required" class="form-control" type="number" value="${rukovodilac.plata}" id="plata" name="plata" placeholder="Npr. 55000">
					  </div>
					</div>

					<div class="form-group row">
					  <div class="col-8 push-1">
					  <%if(rukovodilac==null){ %>
						<input type="hidden" name="akcija" value="unosRukovodioca">
						<input class="btn btn-submit" type="submit" value="Unesi">
					<%} else{ %>
						<input type="hidden" name="akcija" value="izmenaRukovodioca">
						<input type="hidden" name="rukovodilacID" value="<%=rukovodilac.getRukovodilacID()%>">
						<input class="btn btn-submit" type="submit" value="Izmeni">
					<%} %>
					  </div>
					</div>
				</form>	
			</div>
		</div><!-- #content -->

		<div id="footer">
			<footer class="footer-main container text-center">
				<div class="row">
					<div class="col-md-4">
						<p class="footer-main__contact">Kontakt: 032/555-333</p>
					</div>
					<div class="col-md-4 push-md-4">
						<p class="footer-main__developers">Saša - Danijela - Nikola</p>
					</div>
					<div class="col-md-4 pull-md-4">
						<p class="footer-main__project">IP Projekat 2017.</p>
					</div>
				</div>
			</footer>
		</div>
	</div><!-- #wrapper -->

	<!-- Bootstrap core JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
	<script src="js/main.js"></script>
</body>
</html>
<%}else { response.sendRedirect("prijava.jsp");}%>