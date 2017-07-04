<%@page import="rs.Usluga"%>
<%@page import="rs.Tip_sobe"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@page import="rs.Korisnik"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Rezervacija</title>
	
	<!-- Font -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <!-- Custom styles -->
    <link href="css/main.css" rel="stylesheet">
</head>
<body>
	<%
		HttpSession loginSesija = request.getSession();
		String hotelID = request.getParameter("hotelID");
		
		// OD RANIJE
		
		String parametri = "hotelID="+hotelID;
		loginSesija.setAttribute("parametri", parametri);
		
		//
		
		String username = (String)loginSesija.getAttribute("username");
		Korisnik kor = (Korisnik)loginSesija.getAttribute("kor");
		
		ArrayList<Usluga>lsusl = (ArrayList<Usluga>)loginSesija.getAttribute("lsusl");
		ArrayList<Tip_sobe>lsts = (ArrayList<Tip_sobe>)loginSesija.getAttribute("lsts");
		
		
		
		if(username!=null){
	%>
	<div id="wrapper">
	  		<div id="header">
				<nav class="navbar navbar-toggleable-md navbar-light bg-faded" id="nav--main">
					<div class="container">
						<button class="navbar-toggler navbar-toggler-right collapsed" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
						</button>
						<a class="navbar-brand" href="index.jsp"><img class="img-fluid" src="img/logo.png" alt=""></a>
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

  			<section id="content">
  				<div class="container">
				    <div class="reservation-form-container">
				   		<h2 class="text-center">Unesite podatke za rezervaciju</h2>
				   		<h1 class="msg msg--error">${msg}</h1>
				    	<form action="Servlet_rezervacija?akcija=Rezervisi&hotelID=<%=hotelID%>" method="post">
				    		<div class="form-group row">
							  <label for="datum_prijavljivanja" class="col-3 col-form-label">Datum dolaska:</label>
							  <div class="col-9">
							    <input required="required" class="form-control" type="date" value="${param.datum_prijavljivanja}" id="datum_prijavljivanja" name="datum_prijavljivanja" placeholder="Npr. 2017-01-31">
							  </div>
							</div>
							<div class="form-group row">
							  <label for="datum_odlaska" class="col-3 col-form-label">Datum odlaska</label>
							  <div class="col-9">
							    <input class="form-control" type="date" value="${param.datum_odlaska}" id="datum_odlaska" name="datum_odlaska" placeholder="Npr. 2017-03-31">
							  </div>
							</div>
							<div class="form-group row">
							  <label for="uslugaID" class="col-3 col-form-label">Vrsta usluge</label>
							  <div class="col-9">
								<select class="custom-select" name="uslugaID" id="uslugaID">
									<%for(Usluga usluga:lsusl){%>
									<option value="<%=usluga.getUslugaID()%>"><%=usluga.getVrsta_usluge()%></option>
									<%}%>
								</select>
							  </div>
							</div>
							<div class="form-group row">
							  <label for="tip_sobe" class="col-3 col-form-label">Tip sobe</label>
							  <div class="col-9">
								<select class="custom-select" name="tip_sobe" id="tip_sobe">
									<%for(Tip_sobe ts:lsts){%>
									<option value="<%=ts.getNaziv()%>"><%=ts.getNaziv()%></option>
									<%}%>
								</select>
							  </div>
							</div>
							<div class="form-group row">
							  <label for="broj_licne_karte" class="col-3 col-form-label">Lična karta</label>
							  <div class="col-9">
							    <input disabled="disabled" class="form-control" type="number" max="999999999" value="${kor.broj_licne_karte}" id="broj_licne_karte" name="broj_licne_karte" placeholder="Npr. 001234567">
							     <input type="hidden" value="${kor.broj_licne_karte}" name="broj_licne_karte">
							  </div>
							</div>
							<div class="form-group row">
							  <label for="ime" class="col-3 col-form-label">Ime</label>
							  <div class="col-9">
							    <input required="required" disabled="disabled" class="form-control" type="text" value="${kor.ime}" id="ime" name="ime" placeholder="Npr. Petar">
							  </div>
							</div>
								
							<div class="form-group row">
							  <label for="prezime" class="col-3 col-form-label">Prezime</label>
							  <div class="col-9">
							    <input required="required" disabled="disabled" class="form-control" type="text" value="${kor.prezime}" id="prezime" name="prezime" placeholder="Npr. Petrović">
							  </div>
							</div>

							<div class="form-group row">
							  <label for="adresa" class="col-3 col-form-label">Adresa</label>
							  <div class="col-9">
							    <input required="required" disabled="disabled" class="form-control" type="text" value="${kor.adresa}" id="adresa" name="adresa" placeholder="Npr. Svetog Save 66, Čačak">
							  </div>
							</div>

							<div class="form-group row">
							  <label for="email" class="col-3 col-form-label">Email</label>
							  <div class="col-9">
							    <input required="required" disabled="disabled" class="form-control" type="email" value="${kor.email}" id="email" name="email" placeholder="Npr. petarpetrovic95@gmail.com">
							  </div>
							</div>
							
							<div class="form-group row">
							 	<div class="push-3 col-2">
									<input type="submit" value="Rezerviši" class="btn btn-submit">
							 	</div>
							</div>
							
						</form>	
				    </div>
			    </div>
  			</section><!-- #content -->

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
</body>
</html>