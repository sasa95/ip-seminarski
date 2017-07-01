<%@page import="java.util.ArrayList"%>
<%@page import="rs.Korisnik"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Prijava</title>
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
		String username = (String)loginSesija.getAttribute("username");
		if(username==null){
	%>

	<div id="wrapper">
	  		<div id="header">
				<nav class="navbar navbar-toggleable-md navbar-light bg-faded" id="nav--main">
					<div class="container">
						<button class="navbar-toggler navbar-toggler-right collapsed" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
						</button>
						<a class="navbar-brand" href="index.html">Logo</a>
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
  				<h2 class="msg msg--error text-center">${msg}</h2>
				<h2 class="msg msg--success text-center">${msgSuccess}</h2>
				<div class="login-form-container">
					  <form action="Servlet_sesija" method="post">
					  	<h1 class="text-center mb-4">Prijavite se</h1>
					    <div class="form-group row">
					      <label for="username" class="col-sm-4 col-form-label">Korisničko ime</label>
					      <div class="col-sm-8">
					        <input type="text" class="form-control" id="username" name="username" value="${param.username}">
					      </div>
					    </div>
					    <div class="form-group row">
					      <label for="password" class="col-sm-4 col-form-label">Lozinka</label>
					      <div class="col-sm-8">
					        <input type="password" class="form-control" id="password" name="password">
					      </div>
					    </div>
					    <div class="form-group row">
					      <div class="col-sm-2 push-sm-4">
					        <input class="btn btn-submit" type="submit" value="Prijava" name="akcija">
					      </div>
					    </div>
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
	<%}else response.sendRedirect("index.jsp"); %>
</body>
</html>