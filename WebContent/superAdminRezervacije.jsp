<%@page import="rs.Hotel_Rezervacija_UslugaDATE"%>
<%@page import="rs.Hotel_Rezervacija_Usluga"%>
<%@page import="rs.Rezervacija"%>
<%@page import="rs.Hotel"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
     
<%

	HttpSession superAdminSesija = request.getSession();
	String adminUsername = (String)superAdminSesija.getAttribute("adminUsername");
	ArrayList<Hotel_Rezervacija_UslugaDATE>lsrez = (ArrayList<Hotel_Rezervacija_UslugaDATE>)request.getAttribute("lsrez");
	ArrayList<Hotel>lsh = (ArrayList<Hotel>)request.getAttribute("lsh");
	String hotelID = request.getParameter("hotelID");
	int hot_id=0;
	if(hotelID!=null){
		hot_id = Integer.parseInt(hotelID);
	}
	
	if(adminUsername!=null && !adminUsername.equals("")){
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Rezervacije</title>
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
					<a class="navbar-brand" href="indexSuperAdmin.jsp"><img class="img-fluid" src="img/logo.png" alt=""></a>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav float-lg-right text-center">
						<li class="nav-item"><a class="nav-link" href="administrator?akcija=tabelaHoteli">Hoteli</a></li>
						<li class="nav-item"><a class="nav-link" href="administrator?akcija=tabelaKorisnici">Korisnici</a></li>
						<li class="nav-item"><a class="nav-link" href="administrator?akcija=tabelaRezervacije">Rezervacije</a></li>
							<li class="nav-item dropdown">
							    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><img src="img/korisnici/superAdmin.jpg">Profil</a>
							    <div class="dropdown-menu">
									<a href="administrator?akcija=logout" class="dropdown-item">Odjava</a>
							    </div>
							</li>
						</ul>
					</div>		
				</div>
			</nav>
		</div><!-- #header -->

			<div id="content">
				<div class="container mt-5">
					<div class="form-select-container">
						<form action="administrator" method="get">
							<div class="form-group row" style="justify-content: center">
								<label for="hotelID" class="col-2 col-md-1 col-form-label">Hotel</label>
								<div class="col-9 col-md-4" style="display: inline-block;">
									<select class="custom-select" name="hotelID" id="hotelID" style="width: auto;">
										<option value="0">Svi</option>
										<%for(Hotel hot:lsh){ %>
											<option value="<%=hot.getHotelID()%>" <%if(hot.getHotelID()==hot_id){out.println("selected");}%>><%=hot.getNaziv()%></option>
										<%} %>
									</select><input type="hidden" name="akcija" value="rezervacijeByHotelID">
									<input type="submit" value="Traži" class="btn btn-submit" style="display: inline-block;">
								</div>
							</div>
						</form>
					</div>
				
				<table class="admin-table" border=1>
					<caption>Pregled rezervacija</caption>
					<tr>
						<th>ID</th>
						<th>Hotel</th>
						<th>Datum prijave</th>
						<th>Datum odlaska</th>
						<th>Lična karta</th>
						<th>Soba</th>
						<th>Usluga</th>
					</tr>
					<c:forEach var="rez" items="${lsrez}">
						<tr>
							<td>${rez.rezervacijaID}</td>
							<td>${rez.naziv}</td>
							<td>${rez.datum_prijavljivanja}</td>
							<td>${rez.datum_odlaska}</td>
							<td>${rez.broj_licne_karte}</td>
							<td>${rez.sobaID}</td>
							<td>${rez.vrsta_usluge}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>		    

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