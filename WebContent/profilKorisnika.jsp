<%@page import="rs.Korisnik"%>
<%@page import="rs.Hotel_Rezervacija_Usluga"%>
<%@page import="rs.Hotel_aktivnost"%>
<%@page import="rs.Rezervacija"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<%
	HttpSession loginSesija = request.getSession();
	String username = (String)loginSesija.getAttribute("username");
	
	//Korisnik kor = (Korisnik)loginSesija.getAttribute("kor");
	
	ArrayList<Hotel_Rezervacija_Usluga> lsrez = (ArrayList<Hotel_Rezervacija_Usluga>)loginSesija.getAttribute("lsrez");
	ArrayList<Hotel_aktivnost> lsakt = (ArrayList<Hotel_aktivnost>)loginSesija.getAttribute("lsakt");
	String msg = request.getParameter("msg");
	String status = request.getParameter("status");
	if(username!=null){
%>    
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Profil</title>
	<!-- Font -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <!-- Custom styles -->
    <link href="css/main.css" rel="stylesheet">
</head>
<body>
	<div id="wrapper">
	  		<div id="header">
				<nav class="navbar navbar-toggleable-md navbar-light bg-faded" id="nav--main">
					<div class="container">
						<button class="navbar-toggler navbar-toggler-right collapsed" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
						</button>
						<a class="navbar-brand" href="index.jsp">Logo</a>
						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav float-lg-right text-center">
								<li class="nav-item dropdown">
								    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><img src="img/korisnici/<%=username%>.jpg">Profil</a>
								    <div class="dropdown-menu">
										<a href="Servlet_profil?akcija=profil&username=<%=username%>" class="dropdown-item">Profil korisnika</a>
										<div class="dropdown-divider"></div>	
										<a href="Servlet_sesija?akcija=logout" class="dropdown-item">Odjava</a>
								    </div>
								</li>
							</ul>
						</div>		
					</div>
				</nav>
  			</div><!-- #header -->
  			
			<div id="content">
			   <div class="container">
			   	<div class="row">
			   		<div class="col-lg-6">
			   		<%if(lsrez.size()>0){%>	
			   		
			   		<c:forEach var="rez" items="${lsrez}">	
			   			<div class="reservation-profile-card-container">
			   				<h2 class="card-title">Rezervacija</h2>
			   				<ul class="card-list">
			   					<li class="hotel">Hotel <span>${rez.naziv}</span></li>
			   					<li class="service">Usluga <span>${rez.vrsta_usluge}</span></li>
			   					<li class="room">Soba <span>${rez.sobaID}</span></li>
			   					<li class="date">Dolazak <span class="change-date">${rez.datum_prijavljivanja}</span></li>
			   					<li class="date">Odlazak <span class="change-date">${rez.datum_odlaska}</span></li>
			   				</ul>
			   			</div>
			   		</c:forEach>
			   			
			   		<%} else { %>
					<h2 class="msg msg--error">Nemate rezervacije</h2>
					<%}%>
					
					<%if(lsakt.size()>0){%>
					
					<c:forEach var="akt" items="${lsakt}">	
			   			<div class="reservation-profile-card-container">
			   				<h2 class="card-title">Aktivnost</h2>
			   				<ul class="card-list">
			   					<li class="activity">Naziv <span>${akt.naziv}</span></li>
			   					<li class="date">Datum <span class="change-date">${akt.datum_odrzavanja}</span></li>
			   					<li class="time">Vreme <span class="change-time">${akt.vreme_odrzavanja}</span></li>
			   					<li class="location">Grad <span>${akt.mesto_odrzavanja}</span></li>
			   				</ul>
			   			</div>
			   		</c:forEach>
		   			<%} else { %>
					<h2 class="msg msg--error">Nemate aktivnosti</h2>
					<%}%>
			   			
			   		</div>
			   		<div class="col-lg-6">
			   			<div class="user-details-container">
			   				<h2 class="card-title">Korisnički detalji</h2>
			   				<img src="img/korisnici/${korisnik.korisnicko_ime}.jpg" class="profile-pic">
			   				<form class="text-center my-3" action="UserPicUpload" method="post" enctype="multipart/form-data">
				   				<label class="custom-file text-left">
							  		<input type="file" id="file" name="userPic" class="custom-file-input">
							  		<span class="custom-file-control"></span>
								</label>
								<input type="submit" name="" class="btn pic-submit" value="Potvrdi">
							</form>
							<h2 class="text-center msg <%if(msg!=null){if(status!=null && status.equals("ok")){out.println("msg--success");}else{out.println("msg--error");}}%>"><%if(msg!=null){out.println(msg);}%></h2>
							
			   				<form action="Servlet_profil" method="post">
								<div class="form-group row">
								  <label for="broj_licne_karte" class="col-4 col-form-label">Lična karta</label>
								  <div class="col-8">
								    <input required="required" class="form-control" type="number" value="${korisnik.broj_licne_karte}" id="broj_licne_karte" name="broj_licne_karte" placeholder="Npr. 001234567">
								  </div>
								</div>
								
								<div class="form-group row">
								  <label for="ime" class="col-4 col-form-label">Ime</label>
								  <div class="col-8">
								    <input required="required" class="form-control" type="text" value="${korisnik.ime}" id="ime" name="ime" placeholder="Npr. Petar">
								  </div>
								</div>
									
								<div class="form-group row">
								  <label for="prezime" class="col-4 col-form-label">Prezime</label>
								  <div class="col-8">
								    <input required="required" class="form-control" type="text" value="${korisnik.prezime}" id="prezime" name="prezime" placeholder="Npr. Petrović">
								  </div>
								</div>

								<div class="form-group row">
								  <label for="adresa" class="col-4 col-form-label">Adresa</label>
								  <div class="col-8">
								    <input required="required" class="form-control" type="text" value="${korisnik.adresa}" id="adresa" name="adresa" placeholder="Npr. Svetog Save 66, Čačak">
								  </div>
								</div>

								<div class="form-group row">
								  <label for="email" class="col-4 col-form-label">Email</label>
								  <div class="col-8">
								    <input required="required" class="form-control" type="email" value="${korisnik.email}" id="email" name="email" placeholder="Npr. petarpetrovic95@gmail.com">
								  </div>
								</div>

								<div class="form-group row">
								  <label for="korisnicko_ime" class="col-4 col-form-label">Korisničko ime</label>
								  <div class="col-8">
								    <input class="form-control" type="hidden" value="${korisnik.korisnicko_ime}" id="korisnicko_ime" name="korisnicko_ime">
								     <input disabled="disabled" class="form-control" type="text" value="${korisnik.korisnicko_ime}" id="korisnicko_ime" name="korisnicko_ime">
								  </div>
								</div>
								
								<div class="form-group row">
								  <label for="lozinka1" class="col-4 col-form-label">Trenutna Lozinka</label>
								  <div class="col-8">
								    <input class="form-control" type="password" id="lozinka1" name="lozinka1">
								  </div>
								</div>

								<div class="form-group row">
								  <label for="lozinka2" class="col-4 col-form-label">Nova Lozinka</label>
								  <div class="col-8">
								    <input class="form-control" type="password" id="lozinka2" name="lozinka2">
								  </div>
								</div>

								<input type="hidden" name="akcija" value="izmeniKorisnickeDetalje">
								<input class="btn btn-submit" type="submit" value="Izmeni">
							</form>	
			   			</div>
			   		</div>
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
<%}else {
	String url = request.getRequestURL().toString();
	response.sendRedirect("prijava.jsp"); 
}
%>