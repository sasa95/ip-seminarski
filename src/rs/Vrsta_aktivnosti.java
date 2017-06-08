package rs;

public class Vrsta_aktivnosti {
private int vrsta_aktivnostiID;
private String naziv_vrste_aktivnosti;
public int getVrsta_aktivnostiID() {
	return vrsta_aktivnostiID;
}
public void setVrsta_aktivnostiID(int vrsta_aktivnostiID) {
	this.vrsta_aktivnostiID = vrsta_aktivnostiID;
}
public String getNaziv_vrste_aktivnosti() {
	return naziv_vrste_aktivnosti;
}
public void setNaziv_vrste_aktivnosti(String naziv_vrste_aktivnosti) {
	this.naziv_vrste_aktivnosti = naziv_vrste_aktivnosti;
}
public Vrsta_aktivnosti(String naziv_vrste_aktivnosti) {
	super();
	this.naziv_vrste_aktivnosti = naziv_vrste_aktivnosti;
}
public Vrsta_aktivnosti() {
	super();
	// TODO Auto-generated constructor stub
}
}
