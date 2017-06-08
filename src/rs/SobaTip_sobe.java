package rs;

public class SobaTip_sobe {
	private int sobaID,broj_sprata,broj_kreveta,hotelID,tip_sobe,brojSoba;
	private String nazivTipaSobe;
	public int getSobaID() {
		return sobaID;
	}
	public void setSobaID(int sobaID) {
		this.sobaID = sobaID;
	}
	public int getBroj_sprata() {
		return broj_sprata;
	}
	public void setBroj_sprata(int broj_sprata) {
		this.broj_sprata = broj_sprata;
	}
	public int getBroj_kreveta() {
		return broj_kreveta;
	}
	public void setBroj_kreveta(int broj_kreveta) {
		this.broj_kreveta = broj_kreveta;
	}
	public int getHotelID() {
		return hotelID;
	}
	public void setHotelID(int hotelID) {
		this.hotelID = hotelID;
	}
	public int getTip_sobe() {
		return tip_sobe;
	}
	public void setTip_sobe(int tip_sobe) {
		this.tip_sobe = tip_sobe;
	}
	public String getNazivTipaSobe() {
		return nazivTipaSobe;
	}
	public void setNazivTipaSobe(String nazivTipaSobe) {
		this.nazivTipaSobe = nazivTipaSobe;
	}
	
	public int getBrojSoba() {
		return brojSoba;
	}
	public void setBrojSoba(int brojSoba) {
		this.brojSoba = brojSoba;
	}
	public SobaTip_sobe(int sobaID, int broj_sprata, int broj_kreveta, int hotelID, int tip_sobe,
			String nazivTipaSobe) {
		super();
		this.sobaID = sobaID;
		this.broj_sprata = broj_sprata;
		this.broj_kreveta = broj_kreveta;
		this.hotelID = hotelID;
		this.tip_sobe = tip_sobe;
		this.nazivTipaSobe = nazivTipaSobe;
	}
	public SobaTip_sobe() {
		super();
		// TODO Auto-generated constructor stub
	}
}
