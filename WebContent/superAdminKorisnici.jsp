<%@page import="rs.Korisnik"%>
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
	ArrayList<Korisnik>lskor = (ArrayList<Korisnik>)request.getAttribute("lskor");
	ArrayList<Hotel>lshotid = (ArrayList<Hotel>)request.getAttribute("lshotid");
	Korisnik korisnik = (Korisnik)superAdminSesija.getAttribute("korisnik");
	String msg = request.getParameter("msg");
	
	
	
	String status = request.getParameter("status");
	if(adminUsername!=null && !adminUsername.equals("")){
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Korisnici</title>
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
					<div class="admin-table-container">
						<table class="admin-table" border=1>
							<caption>Pregled svih korisnika</caption>
							<tr>
								<th>Ime</th>
								<th>Prezme</th>
								<th>Broj lične karte</th>
								<th>Adresa</th>
								<th>Email</th>
								<th>Korisnicko ime</th>
								<th>Tip korisnika</th>
								<th colspan="2" style="text-align: center">Akcija</th>
							</tr>
							<%for(Korisnik k:lskor){%>
								<tr>
									<td><%=k.getIme()%></td>
									<td><%=k.getPrezime()%></td>
									<td><%=k.getBroj_licne_karte()%></td>
									<td><%=k.getAdresa()%></td>
									<td><%=k.getEmail()%></td>
									<td><%=k.getKorisnicko_ime()%></td>
									<td><%=k.getTip_korisnika()%></td>
									<td><%if(k.getTip_korisnika().equals("admin_hotela")){out.println("<a class=\"edit-record\" href=\"administrator?akcija=izmeniKorisnika&user="+k.getKorisnicko_ime()+"\">Izmeni</a>");}%></td>
									<td><a class="delete-record" href="administrator?akcija=obrisiKorisnika&user=<%=k.getKorisnicko_ime()%>">Obriši</a></td>
								</tr>
							<%} %>
						</table>
					</div>
					<%
					if(status!=null){
						if(status.equals("okI")){
							out.println("<h3 class=\"text-center msg msg--success\">Uspešan unos korisnika!</h3>");
						}
						
						else if(status.equals("okD")){
							out.println("<h3 class=\"text-center msg msg--success\">Uspešno obrisan korisnik!</h3>");
						}
						
						else if(status.equals("okU")){
							out.println("<h3 class=\"text-center msg msg--success\">Uspešno izmenjen korisnik!</h3>");
						}
						
						else if(status.equals("empty")){
							out.println("<h3 class=\"text-center msg msg--error\">Morate popuniti sva polja</h3>");
						}
						
						else if(status.equals("format")){
							out.println("<h3 class=\"text-center msg msg--error\">Neispravan format unosa!</h3>");
						}
					}
					%>
					
					<div class="admin-form-container">
						<form action="administrator" method="post">
							<div class="form-group row">
							  <label for="broj_licne_karte" class="col-4 col-form-label">Lična karta</label>
							  <div class="col-8">
							    <input required="required" class="form-control" type="number" min="111111111" value="${korisnik.broj_licne_karte}" id="broj_licne_karte" name="broj_licne_karte" placeholder="Npr. 001234567">
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
								<%if(korisnik==null){%>
										<input class="form-control" id="korisnicko_ime" type="text" placeholder="Npr. petar_petrovic" name="korisnicko_ime" required="required" value="${korisnik.korisnicko_ime}">
									<%} else {%>
										<input class="form-control" disabled="disabled" id="korisnicko_ime" type="text" placeholder="Npr. petar_petrovic" name="korisnicko_ime" required="required" value="${korisnik.korisnicko_ime}">
										<input id="korisnicko_ime" type="hidden" placeholder="Npr. petar_petrovic" name="korisnicko_ime" required="required" value="${korisnik.korisnicko_ime}">
								<%} %>			
							  </div>
							</div>
							
							<div class="form-group row">
							  <label for="lozinka" class="col-4 col-form-label">Lozinka</label>
							  <div class="col-8">
							    <input required="required" class="form-control" type="password" value="${korisnik.lozinka}" id="lozinka" name="lozinka">
							  </div>
							</div>
							
							<div class="form-group row">
								<label for="hotelID" class="col-4 col-form-label">Hotel</label>
								<div class="col-8">
									<select class="custom-select" name="hotelID" id="hotelID" style="width: auto;">
										<option value=""></option>
										<% for(Hotel pom:lshotid){ %>
											<option value="<%=pom.getHotelID()%>" <%if(korisnik!=null && korisnik.getHotelID()==pom.getHotelID()){out.println("selected");}%>><%=pom.getNaziv()%></option>
										<%} %>
									</select>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-8 push-1">
									<%if(korisnik==null){%>
										<input type="hidden" name="akcija" value="unosKorisnika">
										<input class="btn btn-submit" type="submit" value="Unesi">
									<%} else {%>
										<input type="hidden" name="akcija" value="izmenaKorisnika">
										<input type="hidden" name="user" value="${korisnik.korisnicko_ime}">
										<input class="btn btn-submit" type="submit" value="Izmeni">
									<%} %>	
								</div>
							</div>
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