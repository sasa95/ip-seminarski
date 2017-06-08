package rs;

public class Trzni_centar {
	private int trzni_centarID,hotelID;
	private String naziv,lokacija;
	public int getTrzni_centarID() {
		return trzni_centarID;
	}
	public void setTrzni_centarID(int trzni_centarID) {
		this.trzni_centarID = trzni_centarID;
	}
	public int getHotelID() {
		return hotelID;
	}
	public void setHotelID(int hotelID) {
		this.hotelID = hotelID;
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
	public Trzni_centar(int hotelID, String naziv, String lokacija) {
		super();
		this.hotelID = hotelID;
		this.naziv = naziv;
		this.lokacija = lokacija;
	}
	public Trzni_centar() {
		super();
		// TODO Auto-generated constructor stub
	}
}
