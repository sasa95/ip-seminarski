<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Registracija</title>
	
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
								    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Profil</a>
								    <div class="dropdown-menu">
										<a href="prijava.jsp" class="dropdown-item">Prijava</a>
										<a href="registracija.jsp" class="dropdown-item">Registracija</a>
								    </div>
								</li>
							</ul>
						</div>		
					</div>
				</nav>
  			</div><!-- #header -->

  			<section id="content">
				<div class="user-registration-container">
					<h2 class="msg msg--error">${msg}</h2>
					<h2 class="my-5">Popunite podatke za registraciju:</h2>
	   				<form action="Servlet_registracija" method="post">
						<div class="form-group row">
						  <label for="broj_licne_karte" class="col-4 col-form-label">Lična karta</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="number" min="111111111" value="${param.broj_licne_karte}" id="broj_licne_karte" name="broj_licne_karte" placeholder="Npr. 001234567">
						  </div>
						</div>
						
						<div class="form-group row">
						  <label for="ime" class="col-4 col-form-label">Ime</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="text" value="${param.ime}" id="ime" name="ime" placeholder="Npr. Petar">
						  </div>
						</div>
							
						<div class="form-group row">
						  <label for="prezime" class="col-4 col-form-label">Prezime</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="text" value="${param.prezime}" id="prezime" name="prezime" placeholder="Npr. Petrović">
						  </div>
						</div>

						<div class="form-group row">
						  <label for="adresa" class="col-4 col-form-label">Adresa</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="text" value="${param.adresa}" id="adresa" name="adresa" placeholder="Npr. Svetog Save 66, Čačak">
						  </div>
						</div>

						<div class="form-group row">
						  <label for="email" class="col-4 col-form-label">Email</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="email" value="${param.email}" id="email" name="email" placeholder="Npr. petarpetrovic95@gmail.com">
						  </div>
						</div>

						<div class="form-group row">
						  <label for="korisnicko_ime" class="col-4 col-form-label">Korisničko ime</label>
						  <div class="col-8">
						    <input class="form-control" type="text" value="${param.korisnicko_ime}" id="korisnicko_ime" name="korisnicko_ime">
						  </div>
						</div>
						
						<div class="form-group row">
						  <label for="lozinka1" class="col-4 col-form-label">Lozinka</label>
						  <div class="col-8">
						    <input required="required" class="form-control" type="password" value="" id="lozinka1" name="lozinka1">
						  </div>
						</div>

						<div class="form-group row">
						  <label for="lozinka2" class="col-4 col-form-label">Ponovite Lozinku</label>
						  <div class="col-8">
						    <input class="form-control" type="password" value="" id="lozinka2" name="lozinka2">
						  </div>
						</div>

						<input type="hidden" name="akcija" value="izmeniKorisnickeDetalje">
						<input class="btn btn-submit" type="submit" value="Registracija" name="registracija">


					</form>	
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
</body>
</html>