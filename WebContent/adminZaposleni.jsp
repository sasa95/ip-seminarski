<%@page import="rs.Rukovodilac"%>
<%@page import="rs.Zaposleni_posao"%>
<%@page import="rs.Posao"%>
<%@page import="rs.Zaposleni"%>
<%@page import="rs.Hotel_Rezervacija_Usluga"%>
<%@page import="rs.Hotel"%>
<%@page import="rs.Korisnik"%>
<%@page import="rs.Vrsta_aktivnosti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rs.DAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
     
<%
	HttpSession adminSesija = request.getSession();
	String adminUsername = (String)adminSesija.getAttribute("adminUsername");
	String msg = request.getParameter("msg");
	Hotel hotel = (Hotel)request.getAttribute("hotel");
	ArrayList<Zaposleni_posao>lszap = (ArrayList<Zaposleni_posao>)request.getAttribute("lszap");
	ArrayList<Posao>lsp = (ArrayList<Posao>)request.getAttribute("lsp");
	ArrayList<Rukovodilac>lsruk = (ArrayList<Rukovodilac>)request.getAttribute("lsruk");
	Zaposleni zaposleni = (Zaposleni)adminSesija.getAttribute("zaposleni");
	Rukovodilac rukovodilac = (Rukovodilac)adminSesija.getAttribute("rukovodilac");
	String zaposleniEdit = request.getParameter("zaposleniID");
	
	
	String status = request.getParameter("status");
	if(adminUsername!=null && !adminUsername.equals("")){
		int hot_id = (Integer)adminSesija.getAttribute("hot_id");
%>    
     
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Zaposleni</title>
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
					<a class="navbar-brand" href="indexAdmin.jsp"><img class="img-fluid" src="img/logo.png" alt=""></a>
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
			<div class="container admin-table-container">
			<h3 class="msg msg--error text-center"><%if(msg!=null){out.println(msg);}%></h3>
			<%
				if(status!=null){
					if(status.equals("okI")){
						out.println("<h3 class=\"msg msg--success text-center\">Uspešan unos zaposlenog</h3>");
					}
					
					else if(status.equals("okD")){
						out.println("<h3 class=\"msg msg--success text-center\">Uspešno brisanje zaposlenog</h3>");
					}
					
					if(status.equals("okU")){
						out.println("<h3 class=\"msg msg--success text-center\">Uspešno ažuriranje zaposlenog</h3>");
					}
				}
			%>
				<table class="admin-table" border=1>
				<caption>Zaposleni hotela ${hotel.naziv}</caption>
					<tr>
						<th>ID</th>
						<th>Ime</th>
						<th>Prezime</th>
						<th>Plata</th>
						<th>Posao</th>
						<th>Rukovodilac</th>
						<th></th>
						<th></th>
					</tr>
					<c:forEach var="pom" items="${lszap}">
						<tr>
							<td>${pom.zaposleniID}</td>
							<td>${pom.ime}</td>
							<td>${pom.prezime}</td>
							<td>${pom.plata}</td>
							<td>${pom.naziv_posla}</td>
							<td>${pom.imeRuk} ${pom.prezimeRuk}</td>
							<td><a class="delete-record" href="Servlet_admin?akcija=obrisiZaposlenog&zaposleniID=${pom.zaposleniID}">Obriši</a></td>
							<td><a class="edit-record" href="Servlet_admin?akcija=izmeniZaposlenog&zaposleniID=${pom.zaposleniID}">Izmeni</a></td>
						</tr>
					</c:forEach>
				</table>
		
			</div>
			<div class="admin-form-container">
				<form action="Servlet_admin" method="post">
					<div class="form-group row">
					  <label for="ime" class="col-4 col-form-label">Ime</label>
					  <div class="col-8">
					    <input required="required" class="form-control" type="text" value="${zaposleni.ime}" id="ime" name="ime" placeholder="Npr. Petar">
					  </div>
					</div>
						
					<div class="form-group row">
					  <label for="prezime" class="col-4 col-form-label">Prezime</label>
					  <div class="col-8">
					    <input required="required" class="form-control" type="text" value="${zaposleni.prezime}" id="prezime" name="prezime" placeholder="Npr. Petrović">
					  </div>
					</div>

					<div class="form-group row">
					  <label for="plata" class="col-4 col-form-label">Plata</label>
					  <div class="col-8">
					    <input required="required" class="form-control" type="number" value="${zaposleni.plata}" id="plata" name="plata" placeholder="Npr. 55000">
					  </div>
					</div>
		
					<div class="form-group row">
					  <label for="posao" class="col-4 col-form-label">Posao</label>
					  <div class="col-8">
						<select class="custom-select" name="posaoID" id="posaoID">
							<option value=""></option>
							<%
								if(zaposleni!=null){
									for(Posao pos:lsp){
							%>
								<option value="<%=pos.getPosaoID()%>"<%if(pos.getPosaoID()==zaposleni.getPosaoID()){out.println("selected");}%>><%=pos.getNaziv_posla()%></option>
							<%}} else {%>
								
								<c:forEach var="pos" items="${lsp}">
									<option value="${pos.posaoID}">${pos.naziv_posla}</option>
								</c:forEach>
							<%} %>
						</select>
					  </div>
					</div>
					
					<div class="form-group row">
					  <label for="rukovodilacID" class="col-4 col-form-label">Rukovodilac</label>
					  <div class="col-8">
						<select class="custom-select" name="rukovodilacID" id="rukovodilacID">
							<option value=""></option>
							<%
								if(zaposleni!=null){
									for(Rukovodilac ruk:lsruk){
							%>
								<option value="<%=ruk.getRukovodilacID()%>"<%if(ruk.getRukovodilacID()==zaposleni.getRukovodilacID()){out.println("selected");}%>><%=ruk.getIme() +" "+ruk.getPrezime()%></option>
							<%}} else {%>
								
							<c:forEach var="ruk" items="${lsruk}">
								<option value="${ruk.rukovodilacID}">${ruk.ime} ${ruk.prezime}</option>
							</c:forEach>
							<%} %>
						</select>
					  </div>
					</div>

					<div class="form-group row">
					  <div class="col-8 push-1">
					   <%if(zaposleni==null){ %>
							<input type="hidden" name="akcija" value="unosZaposlenog">
							<input class="btn btn-submit" type="submit" value="Unesi">
						<%} else{ %>
							<input type="hidden" name="akcija" value="izmenaZaposlenog">
							<input type="hidden" name="zaposleniID" value="<%=zaposleniEdit%>">
							<input class="btn btn-submit" type="submit" value="Izmeni">
						<%} %>
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
<%}else { response.sendRedirect("prijava.jsp");}%>