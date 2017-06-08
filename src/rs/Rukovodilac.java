package rs;

public class Rukovodilac {
private int rukovodilacID;
private String ime,prezime;
private float plata;
public int getRukovodilacID() {
	return rukovodilacID;
}
public void setRukovodilacID(int rukovodilacID) {
	this.rukovodilacID = rukovodilacID;
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
public float getPlata() {
	return plata;
}
public void setPlata(float plata) {
	this.plata = plata;
}
public Rukovodilac(String ime, String prezime, float plata) {
	super();
	this.ime = ime;
	this.prezime = prezime;
	this.plata = plata;
}
public Rukovodilac() {
	super();
	// TODO Auto-generated constructor stub
}
}
