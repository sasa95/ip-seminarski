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
<form action="Servlet" method="post">
${msg }<br><br>
	<label for="broj_licne_karte">Broj lične karte: </label>
	<input type="text" placeholder="broj_licne_karte" name="broj_licne_karte"><br>
	
	<label for="ime">Ime: </label>
	<input type="text" placeholder="ime" name="ime"><br>
	
	<label for="prezime">Prezime: </label>
	<input type="text" placeholder="prezime" name="prezime"><br>
	
	<label for="adresa">Adresa: </label>
	<input type="text" placeholder="adresa" name="adresa"><br><br>
	
	<label for="korisnicko_ime">Korisničko ime: </label>
	<input type="text" placeholder="korisnicko_ime" name="korisnicko_ime"><br>
	
	<label for="lozinka1">Lozinka: </label>
	<input type="password" placeholder="lozinka" name="lozinka1"><br>
	
	<label for="lozinka2">Ponovite lozinku: </label>
	<input type="password" placeholder="lozinka" name="lozinka2"><br>
	
	<input type="submit" value="Registracija" name="registracija">
</form>
</body>
</html>