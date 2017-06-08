package rs;

public class Aktivnost {
private int aktivnostID,vrsta_aktivnostiID;
private String naziv,opis;
public int getAktivnostID() {
	return aktivnostID;
}
public void setAktivnostID(int aktivnostID) {
	this.aktivnostID = aktivnostID;
}
public int getVrsta_aktivnostiID() {
	return vrsta_aktivnostiID;
}
public void setVrsta_aktivnostiID(int vrsta_aktivnostiID) {
	this.vrsta_aktivnostiID = vrsta_aktivnostiID;
}
public String getNaziv() {
	return naziv;
}
public void setNaziv(String naziv) {
	this.naziv = naziv;
}
public String getOpis() {
	return opis;
}
public void setOpis(String opis) {
	this.opis = opis;
}
public Aktivnost(int vrsta_aktivnostiID, String naziv, String opis) {
	super();
	this.vrsta_aktivnostiID = vrsta_aktivnostiID;
	this.naziv = naziv;
	this.opis = opis;
}
public Aktivnost() {
	super();
	// TODO Auto-generated constructor stub
}
}
