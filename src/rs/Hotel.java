package rs;

public class Hotel {
	private int hotelID,kategorija,broj_lezaja;
	private String naziv,adresa;
	public int getHotelID() {
		return hotelID;
	}
	public void setHotelID(int hotelID) {
		this.hotelID = hotelID;
	}
	public int getKategorija() {
		return kategorija;
	}
	public void setKategorija(int kategorija) {
		this.kategorija = kategorija;
	}
	public int getBroj_lezaja() {
		return broj_lezaja;
	}
	public void setBroj_lezaja(int broj_lezaja) {
		this.broj_lezaja = broj_lezaja;
	}
	public String getNaziv() {
		return naziv;
	}
	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}
	public String getAdresa() {
		return adresa;
	}
	public void setAdresa(String adresa) {
		this.adresa = adresa;
	}
	public Hotel(int kategorija, int broj_lezaja, String naziv, String adresa) {
		super();
		this.kategorija = kategorija;
		this.broj_lezaja = broj_lezaja;
		this.naziv = naziv;
		this.adresa = adresa;
	}
	public Hotel() {
		super();
		// TODO Auto-generated constructor stub
	}
}
