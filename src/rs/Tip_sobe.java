package rs;

public class Tip_sobe {
	private int tip_sobeID;
	private String naziv;
	public int getTip_sobeID() {
		return tip_sobeID;
	}
	public void setTip_sobeID(int tip_sobeID) {
		this.tip_sobeID = tip_sobeID;
	}
	public String getNaziv() {
		return naziv;
	}
	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}
	public Tip_sobe(String naziv) {
		super();
		this.naziv = naziv;
	}
	public Tip_sobe() {
		super();
		// TODO Auto-generated constructor stub
	}
}
