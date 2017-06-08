package rs;

import java.sql.Date;
import java.sql.Timestamp;

public class Hotel_aktivnost {
private Date datum_odrzavanja;
private String mesto_odrzavanja;
private Timestamp vreme_odrzavanja;
private int aktivnostID,hotelID;
public Date getDatum_odrzavanja() {
	return datum_odrzavanja;
}
public void setDatum_odrzavanja(Date datum_odrzavanja) {
	this.datum_odrzavanja = datum_odrzavanja;
}
public String getMesto_odrzavanja() {
	return mesto_odrzavanja;
}
public void setMesto_odrzavanja(String mesto_odrzavanja) {
	this.mesto_odrzavanja = mesto_odrzavanja;
}
public Timestamp getVreme_odrzavanja() {
	return vreme_odrzavanja;
}
public void setVreme_odrzavanja(Timestamp vreme_odrzavanja) {
	this.vreme_odrzavanja = vreme_odrzavanja;
}
public int getAktivnostID() {
	return aktivnostID;
}
public void setAktivnostID(int aktivnostID) {
	this.aktivnostID = aktivnostID;
}
public int getHotelID() {
	return hotelID;
}
public void setHotelID(int hotelID) {
	this.hotelID = hotelID;
}
public Hotel_aktivnost(Date datum_odrzavanja, String mesto_odrzavanja,
		Timestamp vreme_odrzavanja, int aktivnostID, int hotelID) {
	super();
	this.datum_odrzavanja = datum_odrzavanja;
	this.mesto_odrzavanja = mesto_odrzavanja;
	this.vreme_odrzavanja = vreme_odrzavanja;
	this.aktivnostID = aktivnostID;
	this.hotelID = hotelID;
}
public Hotel_aktivnost() {
	super();
	// TODO Auto-generated constructor stub
}
}
