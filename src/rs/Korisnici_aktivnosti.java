package rs;

public class Korisnici_aktivnosti {
private String broj_licne_karte;
private int aktivnostiID;
public String getBroj_licne_karte() {
	return broj_licne_karte;
}
public void setBroj_licne_karte(String broj_licne_karte) {
	this.broj_licne_karte = broj_licne_karte;
}
public int getAktivnostiID() {
	return aktivnostiID;
}
public void setAktivnostiID(int aktivnostiID) {
	this.aktivnostiID = aktivnostiID;
}
public Korisnici_aktivnosti(String broj_licne_karte, int aktivnostiID) {
	super();
	this.broj_licne_karte = broj_licne_karte;
	this.aktivnostiID = aktivnostiID;
}
public Korisnici_aktivnosti() {
	super();
}
}
