package rs;

public class Tretman {
	private int tretmanID;
	private String naziv;
	public int getTretmanID() {
		return tretmanID;
	}
	public void setTretmanID(int tretmanID) {
		this.tretmanID = tretmanID;
	}
	public String getNaziv() {
		return naziv;
	}
	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}
	public Tretman(String naziv) {
		super();
		this.naziv = naziv;
	}

	public Tretman() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
