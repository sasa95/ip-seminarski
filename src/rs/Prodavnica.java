package rs;

public class Prodavnica {
	private int prodavnicaID,trzni_centarID;
	private String naziv,lokacija;
	public int getProdavnicaID() {
		return prodavnicaID;
	}
	public void setProdavnicaID(int prodavnicaID) {
		this.prodavnicaID = prodavnicaID;
	}
	public int getTrzni_centarID() {
		return trzni_centarID;
	}
	public void setTrzni_centarID(int trzni_centarID) {
		this.trzni_centarID = trzni_centarID;
	}
	public String getNaziv() {
		return naziv;
	}
	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}
	public String getLokacija() {
		return lokacija;
	}
	public void setLokacija(String lokacija) {
		this.lokacija = lokacija;
	}
	public Prodavnica(int trzni_centarID, String naziv, String lokacija) {
		super();
		this.trzni_centarID = trzni_centarID;
		this.naziv = naziv;
		this.lokacija = lokacija;
	}
	public Prodavnica() {
		super();
		// TODO Auto-generated constructor stub
	}
}
