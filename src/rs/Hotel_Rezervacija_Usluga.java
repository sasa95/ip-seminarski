package rs;

import java.sql.Timestamp;

public class Hotel_Rezervacija_Usluga {
	private String naziv,broj_licne_karte,vrsta_usluge;
	private int sobaID;
	private Timestamp datum_prijavljivanja,datum_odlaska;
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
	public Timestamp getDatum_prijavljivanja() {
		return datum_prijavljivanja;
	}
	public void setDatum_prijavljivanja(Timestamp datum_prijavljivanja) {
		this.datum_prijavljivanja = datum_prijavljivanja;
	}
	public Timestamp getDatum_odlaska() {
		return datum_odlaska;
	}
	public void setDatum_odlaska(Timestamp datum_odlaska) {
		this.datum_odlaska = datum_odlaska;
	}
	public Hotel_Rezervacija_Usluga(String naziv, String broj_licne_karte, String vrsta_usluge, int sobaID,
			Timestamp datum_prijavljivanja, Timestamp datum_odlaska) {
		super();
		this.naziv = naziv;
		this.broj_licne_karte = broj_licne_karte;
		this.vrsta_usluge = vrsta_usluge;
		this.sobaID = sobaID;
		this.datum_prijavljivanja = datum_prijavljivanja;
		this.datum_odlaska = datum_odlaska;
	}
	public Hotel_Rezervacija_Usluga() {
		super();
		// TODO Auto-generated constructor stub
	}
}
