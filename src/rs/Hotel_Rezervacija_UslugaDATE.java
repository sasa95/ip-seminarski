package rs;

import java.sql.Date;

public class Hotel_Rezervacija_UslugaDATE {
	private String naziv,broj_licne_karte,vrsta_usluge;
	private int sobaID,rezervacijaID;
	private Date datum_prijavljivanja,datum_odlaska;
	public String getNaziv() {
		return naziv;
	}
	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}
	public String getBroj_licne_karte() {
		return broj_licne_karte;
	}
	public void setBroj_licne_karte(String broj_licne_karte) {
		this.broj_licne_karte = broj_licne_karte;
	}
	public String getVrsta_usluge() {
		return vrsta_usluge;
	}
	public void setVrsta_usluge(String vrsta_usluge) {
		this.vrsta_usluge = vrsta_usluge;
	}
	public int getSobaID() {
		return sobaID;
	}
	public void setSobaID(int sobaID) {
		this.sobaID = sobaID;
	}
	public Date getDatum_prijavljivanja() {
		return datum_prijavljivanja;
	}
	public void setDatum_prijavljivanja(Date datum_prijavljivanja) {
		this.datum_prijavljivanja = datum_prijavljivanja;
	}
	public Date getDatum_odlaska() {
		return datum_odlaska;
	}
	public void setDatum_odlaska(Date datum_odlaska) {
		this.datum_odlaska = datum_odlaska;
	}
	
	public int getRezervacijaID() {
		return rezervacijaID;
	}
	public void setRezervacijaID(int rezervacijaID) {
		this.rezervacijaID = rezervacijaID;
	}
	public Hotel_Rezervacija_UslugaDATE(String naziv, String broj_licne_karte, String vrsta_usluge, int sobaID,int rezervacijaID,
			Date datum_prijavljivanja, Date datum_odlaska) {
		super();
		this.naziv = naziv;
		this.broj_licne_karte = broj_licne_karte;
		this.vrsta_usluge = vrsta_usluge;
		this.rezervacijaID=rezervacijaID;
		this.sobaID = sobaID;
		this.datum_prijavljivanja = datum_prijavljivanja;
		this.datum_odlaska = datum_odlaska;
	}
	public Hotel_Rezervacija_UslugaDATE() {
		super();
		// TODO Auto-generated constructor stub
	}
}
