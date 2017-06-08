package rs;

import java.sql.Date;
import java.sql.Timestamp;

public class Hoteli_tretmani {
	private Date datum_zakazivanja;
	private Timestamp vreme_zakazivanja;
	private String napomena,broj_licne_karte;
	private int hotelID,tretmanID;
	public Date getDatum_zakazivanja() {
		return datum_zakazivanja;
	}
	public void setDatum_zakazivanja(Date datum_zakazivanja) {
		this.datum_zakazivanja = datum_zakazivanja;
	}
	public Timestamp getVreme_zakazivanja() {
		return vreme_zakazivanja;
	}
	public void setVreme_zakazivanja(Timestamp vreme_zakazivanja) {
		this.vreme_zakazivanja = vreme_zakazivanja;
	}
	public String getNapomena() {
		return napomena;
	}
	public void setNapomena(String napomena) {
		this.napomena = napomena;
	}
	public String getBroj_licne_karte() {
		return broj_licne_karte;
	}
	public void setBroj_licne_karte(String broj_licne_karte) {
		this.broj_licne_karte = broj_licne_karte;
	}
	public int getHotelID() {
		return hotelID;
	}
	public void setHotelID(int hotelID) {
		this.hotelID = hotelID;
	}
	public int getTretmanID() {
		return tretmanID;
	}
	public void setTretmanID(int tretmanID) {
		this.tretmanID = tretmanID;
	}
	public Hoteli_tretmani(Date datum_zakazivanja, Timestamp vreme_zakazivanja, String napomena,
			String broj_licne_karte, int hotelID, int tretmanID) {
		super();
		this.datum_zakazivanja = datum_zakazivanja;
		this.vreme_zakazivanja = vreme_zakazivanja;
		this.napomena = napomena;
		this.broj_licne_karte = broj_licne_karte;
		this.hotelID = hotelID;
		this.tretmanID = tretmanID;
	}
	public Hoteli_tretmani() {
		super();
		// TODO Auto-generated constructor stub
	}
}
