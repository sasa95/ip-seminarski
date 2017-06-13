<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registracija</title>
</head>
<body>
<h2>Popunite podatke za registraciju:</h2>
<form action="Servlet_registracija" method="post">
${msg }<br><br>
	<label for="broj_licne_karte">Broj lične karte: </label>
	<input type="number" min="100000000" max="999999999" placeholder="Npr. 001234567" name="broj_licne_karte" required="required" value="${param.broj_licne_karte}"><br>
	
	<label for="ime">Ime: </label>
	<input type="text" placeholder="Npr. Petar" name="ime" required="required" value="${param.ime}"><br>
	
	<label for="prezime">Prezime: </label>
	<input type="text" placeholder="Npr. Petrović" name="prezime" required="required" value="${param.prezime}"><br>
	
	<label for="adresa">Adresa: </label>
	<input type="text" placeholder="Npr. Svetog Save 66, Čačak" name="adresa" required="required" value="${param.adresa}"><br>
	
	<label for="email">Email: </label>
	<input type="email" placeholder="Npr. petarpetrovic95@gmail.com" name="email" required="required" value="${param.email}"><br><br>
	
	<label for="korisnicko_ime">Korisničko ime: </label>
	<input type="text" placeholder="Npr. petar_petrovic" name="korisnicko_ime" required="required" value="${param.korisnicko_ime}"><br>
	
	<label for="lozinka1">Lozinka: </label>
	<input type="password" name="lozinka1" required="required" value="${param.lozinka1}"><br>
	
	<label for="lozinka2">Ponovite lozinku: </label>
	<input type="password" name="lozinka2" required="required" value="${param.lozinka2}"><br>
	
	<input type="submit" value="Registracija" name="registracija">
</form>
</body>
</html>