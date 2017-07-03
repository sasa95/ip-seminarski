<%@page import="rs.Vrsta_aktivnostiAktivnost"%>
<%@page import="rs.Aktivnost"%>
<%@page import="rs.Tip_sobe"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="rs.Trzni_centar"%>
<%@page import="rs.Tretman"%>
<%@page import="rs.Usluga"%>
<%@page import="rs.SobaTip_sobe"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="rs.Hotel"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    int j=1;
	Hotel h = (Hotel)request.getAttribute("h");
	ArrayList<SobaTip_sobe> lsts = (ArrayList<SobaTip_sobe>)request.getAttribute("lsts");
	ArrayList<Usluga> lsusluga = (ArrayList<Usluga>)request.getAttribute("lsusluga");
	ArrayList<Tretman> lstretman = (ArrayList<Tretman>)request.getAttribute("lstretman");
	ArrayList<Trzni_centar> lscentar = (ArrayList<Trzni_centar>)request.getAttribute("lscentar");
	ArrayList<Vrsta_aktivnostiAktivnost> lsaktivnost = (ArrayList<Vrsta_aktivnostiAktivnost>)request.getAttribute("lsaktivnost");
	ArrayList<Tip_sobe>lsts_bool = (ArrayList<Tip_sobe>)request.getAttribute("lsts_bool");
	
	
	String id = request.getParameter("id");
	String akcija = request.getParameter("akcija");
	String fullString = "/Servlet?id="+id+"&akcija="+akcija;
	
	HttpSession loginSesija = request.getSession();
	String username = (String)loginSesija.getAttribute("username");
	loginSesija.setAttribute("fullString", fullString);
	%>
    
    
<!DOCTYPE html >
<html>
<head>
	<meta charset="UTF-8"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Hotel detalji</title>
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

  			<section id="content">
			    <div class="container">
				    <div class="single-hotel">
				    	<h1 class="text-center hotel-heading">${h.naziv}</h1>
				    	<img src="img/hoteli/${h.hotelID}.jpg" class="hotel-img" alt="">
				    	<ul class="single-hotel__details">
							<li class="hotel-category">
							<%for(int i=0;i<h.getKategorija();i++){ %>
								<img src="img/icons/star.png">
							<%} %>
							</li><br>
							
							<li class="location">${h.adresa}</li><br>
							<li class="capacity">${h.broj_lezaja}</li>
	  					</ul>
				    	<p class="hotel-description">${h.opis}</p>
				    	<%
							if(lsts_bool.size()>0){
						%>	
							<a href="Servlet_rezervacija?hotelID=${h.hotelID}"class="btn btn-submit btn-submit--red" style="width: 150px;">Rezerviši</a>
						<%}else {%>
							<input type="submit" name="" disabled="disabled" class="btn btn-submit btn-submit--red" value="Rezerviši">
						<%} %>
				    	
				    	<div class="row">
				    		<div class="col-md-6 table-col">
				    			<table class="my-table">
					    			<caption style="caption-side: top">Usluge</caption>
						    		<tr>
						    			<th>Naziv</th>
						    			<th>Cena</th>
						    		</tr>
						    		<c:forEach var="pom" items="${lsusluga}">
										<tr>
											<td>${pom.vrsta_usluge}</td>
											<td>${pom.cena}</td>
										</tr>
									</c:forEach>
					    		</table>
				    		</div>
							<div class="col-md-6 table-col">
								<table class="my-table">
					    			<caption style="caption-side: top">Sobe</caption>
						    		<tr>
						    			<th>Tip</th>
						    			<th>Broj</th>
						    		</tr>
						    		<c:forEach var="pom" items="${lsts}">
										<tr>
											<td>${pom.nazivTipaSobe}</td>
											<td>${pom.brojSoba}</td>
										</tr>
									</c:forEach>
					    		</table>
							</div>
				    	</div>

				    	<div class="row">
				    	<%if(lstretman!=null && lstretman.size()>0){ %>
				    		<div class="col-md-6 table-col">
				    			<table class="my-table">
					    			<caption style="caption-side: top">Tretmani</caption>
						    		<tr>
						    			<th>RB</th>
						    			<th>Naziv</th>
						    		</tr>
						    		<c:forEach var="pom" items="${lstretman}">
										<tr>
											<td><%=j++%></td>
											<td>${pom.naziv}</td>
										</tr>		
									</c:forEach>
					    		</table>
				    		</div>
				    		<%}j=1; %>
				    		<%if(lscentar!=null && lscentar.size()>0){ %>
							<div class="col-md-6 table-col">
								<table class="my-table">
					    			<caption style="caption-side: top">Tržni centri</caption>
						    		<tr>
						    			<th>RB</th>
						    			<th>Naziv</th>
										<th>Adresa</th>
										<th>Grad</th>
										<th>Akcija</th>
						    		</tr>
						    		<c:forEach var="pom" items="${lscentar}">
										<tr>
							    			<td><%=j++%></td>
							    			<td>${pom.naziv}</td>
							    			<td class="cut-address">${pom.lokacija}</td>
							    			<td class="cut-city">${pom.lokacija }</td>
							    			<td><a href="Servlet?centarID=${pom.trzni_centarID}&akcija=detaljiCentra&hotelID=${h.hotelID}" class="btn btn-sm btn-submit btn-submit--red btn-submit--details">Detalji</a></td>
						    			</tr>
									</c:forEach>
					    		</table>
							</div>
							<%} j=1; %>
							<%if(lsaktivnost!=null && lsaktivnost.size()>0){ %>
							<div class="col-md-6 table-col">
								<table class="my-table">
					    			<caption style="caption-side: top">Vrste aktivnosti</caption>
						    		<tr>
						    			<th>RB</th>
						    			<th>Naziv</th>
										<th>Akcija</th>
						    		</tr>
						    		<c:forEach var="pom" items="${lsaktivnost}">
										<tr>
							    			<td><%=j++%></td>
							    			<td>${pom.vrstaAktivnosti}</td>
							    			<td><a href="Servlet?akcija=AktivnostDetalji&aktivnostID=${pom.vrsta_aktivnostiID}&hotelID=${h.hotelID}" class="btn btn-sm btn-submit btn-submit--red btn-submit--details btn-submit--details">Detalji</a></td>
						    			</tr>
									</c:forEach>
					    		</table>
							</div>
							<%} %>
				    	</div>
			    	</div>
			    </div><!--Container -->
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