package rs;

public class Korisnik {
private String broj_licne_karte,ime,prezime,adresa,korisnicko_ime,lozinka,tip_korisnika;
private int hotelID;
public String getBroj_licne_karte() {
	return broj_licne_karte;
}
public void setBroj_licne_karte(String broj_licne_karte) {
	this.broj_licne_karte = broj_licne_karte;
}
public String getIme() {
	return ime;
}
public void setIme(String ime) {
	this.ime = ime;
}
public String getPrezime() {
	return prezime;
}
public void setPrezime(String prezime) {
	this.prezime = prezime;
}
public String getAdresa() {
	return adresa;
}
public void setAdresa(String adresa) {
	this.adresa = adresa;
}
public String getKorisnicko_ime() {
	return korisnicko_ime;
}
public void setKorisnicko_ime(String korisnicko_ime) {
	this.korisnicko_ime = korisnicko_ime;
}
public String getLozinka() {
	return lozinka;
}
public void setLozinka(String lozinka) {
	this.lozinka = lozinka;
}
public String getTip_korisnika() {
	return tip_korisnika;
}
public void setTip_korisnika(String tip_korisnika) {
	this.tip_korisnika = tip_korisnika;
}
public int getHotelID() {
	return hotelID;
}
public void setHotelID(int hotelID) {
	this.hotelID = hotelID;
}
public Korisnik(String broj_licne_karte, String ime, String prezime,
		String adresa, String korisnicko_ime, String lozinka,
		String tip_korisnika, int hotelID) {
	super();
	this.broj_licne_karte = broj_licne_karte;
	this.ime = ime;
	this.prezime = prezime;
	this.adresa = adresa;
	this.korisnicko_ime = korisnicko_ime;
	this.lozinka = lozinka;
	this.tip_korisnika = tip_korisnika;
	this.hotelID = hotelID;
}
public Korisnik() {
	super();
	// TODO Auto-generated constructor stub
}
}
