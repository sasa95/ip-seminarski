package rs;

public class Usluga {
private int uslugaID;
private String vrsta_usluge;
private float cena;
public int getUslugaID() {
	return uslugaID;
}
public void setUslugaID(int uslugaID) {
	this.uslugaID = uslugaID;
}
public String getVrsta_usluge() {
	return vrsta_usluge;
}
public void setVrsta_usluge(String vrsta_usluge) {
	this.vrsta_usluge = vrsta_usluge;
}
public float getCena() {
	return cena;
}
public void setCena(float cena) {
	this.cena = cena;
}
public Usluga(String vrsta_usluge, float cena) {
	super();
	this.vrsta_usluge = vrsta_usluge;
	this.cena = cena;
}
public Usluga() {
	super();
	// TODO Auto-generated constructor stub
}
}
