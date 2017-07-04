<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	HttpSession loginSesija = request.getSession();
	String username = (String)loginSesija.getAttribute("username");
%>   

<!DOCTYPE html>
<html lang="sr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>404</title>
	<!-- Font -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <!-- Custom styles -->
    <link href="css/main.css" rel="stylesheet">
</head>
<body class="body--404">	
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
								    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Profil</a>
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

  			<section id="content">
  				<div class="container-404 text-center mt-5">
  					<h1 class="h-404">404</h1>
			    	<p class="p-404">Stranica kojoj pokušavate pristupiti ne postoji.
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