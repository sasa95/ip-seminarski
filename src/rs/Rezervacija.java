package rs;

import java.sql.Date;
import java.sql.Timestamp;

public class Rezervacija {
private Timestamp datum_prijavljivanja;
private Date datum_odlaska;
private String broj_licne_karte;
private int sobaID,hotelID,uslugaID;
public Timestamp getDatum_prijavljivanja() {
	return datum_prijavljivanja;
}
public void setDatum_prijavljivanja(Timestamp datum_prijavljivanja) {
	this.datum_prijavljivanja = datum_prijavljivanja;
}
public Date getDatum_odlaska() {
	return datum_odlaska;
}
public void setDatum_odlaska(Date datum_odlaska) {
	this.datum_odlaska = datum_odlaska;
}
public String getBroj_licne_karte() {
	return broj_licne_karte;
}
public void setBroj_licne_karte(String broj_licne_karte) {
	this.broj_licne_karte = broj_licne_karte;
}
public int getSobaID() {
	return sobaID;
}
public void setSobaID(int sobaID) {
	this.sobaID = sobaID;
}
public int getHotelID() {
	return hotelID;
}
public void setHotelID(int hotelID) {
	this.hotelID = hotelID;
}
public int getUslugaID() {
	return uslugaID;
}
public void setUslugaID(int uslugaID) {
	this.uslugaID = uslugaID;
}
public Rezervacija(Timestamp datum_prijavljivanja, Date datum_odlaska,
		String broj_licne_karte, int sobaID, int hotelID, int uslugaID) {
	super();
	this.datum_prijavljivanja = datum_prijavljivanja;
	this.datum_odlaska = datum_odlaska;
	this.broj_licne_karte = broj_licne_karte;
	this.sobaID = sobaID;
	this.hotelID = hotelID;
	this.uslugaID = uslugaID;
}
public Rezervacija() {
	super();
	// TODO Auto-generated constructor stub
}
}
