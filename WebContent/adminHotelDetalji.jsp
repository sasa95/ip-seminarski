<%@page import="rs.Hotel"%>
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
	
	String status = request.getParameter("status");
	if(adminUsername!=null && !adminUsername.equals("")){
		int hot_id = (Integer)adminSesija.getAttribute("hot_id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Hotel Detalji</title>
	
	<!-- Font -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <!-- Custom styles -->
    <link href="css/main.css" rel="stylesheet">
<script type="text/javascript">history.forward();</script>
</head>
<body class="admin-body">
	<div id="wrapper">
		<div id="header">
			<nav class="navbar navbar-toggleable-md navbar-light bg-faded" id="nav--main">
				<div class="container">
					<button class="navbar-toggler navbar-toggler-right collapsed" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
					</button>
					<a class="navbar-brand" href="indexAdmin.jsp">Logo</a>
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
			<div class="container">
				<div class="admin-hotel-details-container mt-5">
					<h2 class="text-center mb-4">Izmenite detalje hotela ${hotel.naziv}</h2>
					<img class="hotel-pic" src="img/hoteli/${hot_id}.jpg"/>
					<form class="admin-pic-upload" action="HotelPicUpload" method="post" enctype="multipart/form-data">
						<label class="custom-file" for="hotelPic">
							<input type="file" name="hotelPic" id="hotelPic" class="custom-file-input">
							<span class="custom-file-control"></span>
						</label>
						<input type="submit" class="btn pic-submit" value="Izmeni">
					</form><br>
				

					<%
					if(status!=null){
						if(status.equals("ok")){
							out.println("<h3 class=\"msg msg--success text-center\">Uspešna izmena</h3>");
						}
						
						else if(status.equals("empty")){
							out.println("<h3 class=\"msg msg--success text-center\">Morate popuniti sva polja</h3>");
						}
					}
					%>
					<form action="Servlet_admin?akcija=izmeniHotel" method="post">
						<div class="form-group row">
						  <label for="naziv" class="col-4 col-form-label">Naziv</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="text" value="${hotel.naziv}" id="naziv" name="naziv">
						  </div>
						</div>
						
						<div class="form-group row">
						  <label for="adresa" class="col-4 col-form-label">Adresa</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="text" value="${hotel.adresa}" id="adresa" name="adresa">
						  </div>
						</div>
							
						<div class="form-group row">
						  <label for="kategorija" class="col-4 col-form-label">Kategorija</label>
						  <div class="col-8">
							<select class="custom-select" name="kategorija" id="kategorija">
								<option value="1" <%if(hotel.getKategorija()==1){out.println("selected");}%>>1</option>
								<option value="2" <%if(hotel.getKategorija()==2){out.println("selected");}%>>2</option>
								<option value="3" <%if(hotel.getKategorija()==3){out.println("selected");}%>>3</option>
								<option value="4" <%if(hotel.getKategorija()==4){out.println("selected");}%>>4</option>
								<option value="5" <%if(hotel.getKategorija()==5){out.println("selected");}%>>5</option>
							</select>
						  </div>
						</div>

						<div class="form-group row">
						  <label for="broj_lezaja" class="col-4 col-form-label">Broj Ležaja</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="number" value="${hotel.broj_lezaja}" id="broj_lezaja" name="broj_lezaja">
						  </div>
						</div>
						
						<div class="form-group row">
						  <label for="opis" class="col-4 col-form-label">Opis</label>
						  <div class="col-8">
						    <textarea name="opis" class="form-control" id="opis" rows="3">${hotel.opis}</textarea>
						  </div>
						</div>
						<div class="form-group row">
						  <div class="col-8 push-1">
						   <input class="btn btn-submit" type="submit" value="Izmeni">
						  </div>
						</div>
						<input type="hidden" name="hotelID" value="<%=hot_id%>">
						<input type="hidden" name="returnPath" value="Servlet_admin?akcija=hotelDetalji&hotelID=<%=hot_id%>">
					</form>
				</div>
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