<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<%
	HttpSession loginSesija = request.getSession();
	String username = (String)loginSesija.getAttribute("username");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Početna</title>
	
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
						<a class="navbar-brand" href="index.jsp"><img class="img-fluid" src="img/logo.png" alt=""></a>
						<div class="collapse navbar-collapse" id="navbarSupportedContent">
							<ul class="navbar-nav float-lg-right text-center">
								<li class="nav-item dropdown">
								    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"><%if(username!=null){%><img src="img/korisnici/<%=username%>.jpg"><%} %>Profil</a>
								    <div class="dropdown-menu">
									<%if(username==null){ %>
										<a href="prijava.jsp" class="dropdown-item">Prijava</a>
										<a href="registracija.jsp" class="dropdown-item">Registracija</a>
										<%} else { %>
										<a href="Servlet_profil?akcija=profil&username=<%=username%>" class="dropdown-item">Profil korisnika</a>
										<div class="dropdown-divider"></div>	
										<a href="Servlet_sesija?akcija=logout" class="dropdown-item">Odjava</a>
									<%}%>
								    </div>
								</li>
							</ul>
						</div>		
					</div>
				</nav>
  			</div><!-- #header -->

  			<div id="content">
			    <div class="jumbotron jumbotron-fluid hero-main">
			        <h1 class="hero-main__heading text-center">Pronađite hotel po vašoj meri</h1>
			       	<div class="call-to-action">
			       		<a href="#pretraga" class="btn-hero btn-hero--search">Pretraži</a>
			       		<%if(username==null){ %>
			       		<a href="registracija.jsp" class="btn-hero btn-hero--register">Registruj se</a>
			       		<%} %>
			       	</div>
			    </div><!-- .jumbotron -->	

				    <div class="home-form-container">
				    <p>${msg}</p>
				    	<form action="Servlet" method="get">
							<div class="form-group row">
							  <div class="col-9 pr-0">
							    <input class="form-control main-input" type="search" value="" id="pretraga" name="pretraga" placeholder="Npr. Slavija">
							  </div>
							  <div class="col-3 pl-0"><input class="btn btn--home-submit" type="submit" name="akcija" value="Traži"></div>
							</div>
							<div class="form-group row">
							  <label for="grad" class="col-3 col-form-label">Grad</label>
							  <div class="col-9">
							    <input class="form-control" type="text" value="" id="grad" name="adresa" placeholder="Npr. Beograd">
							  </div>
							</div>
							
							<div class="form-group row">
							  <label for="naziv_vrste_aktivnosti" class="col-3 col-form-label">Aktivnosti</label>
							  <div class="col-9">
								<select class="custom-select" name="naziv_vrste_aktivnosti" id="naziv_vrste_aktivnosti">
									<option selected="selected" value="">Sve</option>
									<option value="Sport">Sport</option>
									<option value="Kultura">Kultura</option>
									<option value="Religija">Religija</option>
									<option value="Zabava">Zabava</option>
									<option value="Edukacija">Edukacija</option>
								</select>
							  </div>
							</div>
							<div class="form-group row">
							  <label for="vrsta_usluge" class="col-3 col-form-label">Usluge</label>
							  <div class="col-9">
								<select class="custom-select" name="vrsta_usluge" id="vrsta_usluge">
									<option selected="selected" value="">Sve</option>
									<option value="pansion">Pansion</option>
									<option value="polu-pansion">Polu-pansion</option>
									<option value="full-pansion">Full-pansion</option>	
								</select>
							  </div>
							</div>
							<div class="form-group row">
								<div class="col-sm-3 categories-label">Kategorije</div>
								<div class="col-sm-9 home-categories">
									<div class="form-check form-check-inline">
									  <label class="form-check-label">
									    <input class="form-check-input" type="checkbox" name="kategorija" value="1" checked="checked"> 1
									  </label>
									</div>
									<div class="form-check form-check-inline">
									  <label class="form-check-label">
									    <input class="form-check-input" type="checkbox" name="kategorija" value="2" checked="checked"> 2
									  </label>
									</div>
									<div class="form-check form-check-inline">
									  <label class="form-check-label">
									    <input class="form-check-input" type="checkbox" name="kategorija" value="3" checked="checked"> 3
									  </label>
									</div>
									<div class="form-check form-check-inline">
									  <label class="form-check-label">
									    <input class="form-check-input" type="checkbox" name="kategorija" value="4" checked="checked"> 4
									  </label>
									</div>
									<div class="form-check form-check-inline">
									  <label class="form-check-label">
									    <input class="form-check-input" type="checkbox" name="kategorija" value="5" checked="checked"> 5
									  </label>
									</div>
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