package rs;

public class Zaposleni {
private int zaposleniID,hotelID,posaoID,rukovodilacID;
private String ime,prezime;
private float plata;
public int getZaposleniID() {
	return zaposleniID;
}
public void setZaposleniID(int zaposleniID) {
	this.zaposleniID = zaposleniID;
}
public int getHotelID() {
	return hotelID;
}
public void setHotelID(int hotelID) {
	this.hotelID = hotelID;
}
public int getPosaoID() {
	return posaoID;
}
public void setPosaoID(int posaoID) {
	this.posaoID = posaoID;
}
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
public Zaposleni(int hotelID, int posaoID, int rukovodilacID, String ime,
		String prezime, float plata) {
	super();
	this.hotelID = hotelID;
	this.posaoID = posaoID;
	this.rukovodilacID = rukovodilacID;
	this.ime = ime;
	this.prezime = prezime;
	this.plata = plata;
}
public Zaposleni() {
	super();
	// TODO Auto-generated constructor stub
}
}
