package rs;

public class Posao {
private int posaoID;
private String naziv_posla,opis;
public int getPosaoID() {
	return posaoID;
}
public void setPosaoID(int posaoID) {
	this.posaoID = posaoID;
}
public String getNaziv_posla() {
	return naziv_posla;
}
public void setNaziv_posla(String naziv_posla) {
	this.naziv_posla = naziv_posla;
}
public String getOpis() {
	return opis;
}
public void setOpis(String opis) {
	this.opis = opis;
}
public Posao(String naziv_posla, String opis) {
	super();
	this.naziv_posla = naziv_posla;
	this.opis = opis;
}
public Posao() {
	super();
	// TODO Auto-generated constructor stub
}	
}
