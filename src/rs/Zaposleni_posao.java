package rs;

public class Zaposleni_posao {
	private int zaposleniID,hotelID,posaoID,rukovodilacID;
	private String ime,prezime,naziv_posla,imeRuk,prezimeRuk;
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
	public String getNaziv_posla() {
		return naziv_posla;
	}
	public void setNaziv_posla(String naziv_posla) {
		this.naziv_posla = naziv_posla;
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
	
	public String getImeRuk() {
		return imeRuk;
	}
	public void setImeRuk(String imeRuk) {
		this.imeRuk = imeRuk;
	}
	public String getPrezimeRuk() {
		return prezimeRuk;
	}
	public void setPrezimeRuk(String prezimeRuk) {
		this.prezimeRuk = prezimeRuk;
	}
	
	public Zaposleni_posao(int hotelID, int posaoID, int rukovodilacID, String ime, String prezime, String naziv_posla,
			String imeRuk, String prezimeRuk, float plata) {
		super();
		this.hotelID = hotelID;
		this.posaoID = posaoID;
		this.rukovodilacID = rukovodilacID;
		this.ime = ime;
		this.prezime = prezime;
		this.naziv_posla = naziv_posla;
		this.imeRuk = imeRuk;
		this.prezimeRuk = prezimeRuk;
		this.plata = plata;
	}
	public Zaposleni_posao() {
		super();
		// TODO Auto-generated constructor stub
	}
}
