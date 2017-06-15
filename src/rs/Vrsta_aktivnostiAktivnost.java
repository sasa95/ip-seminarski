package rs;

public class Vrsta_aktivnostiAktivnost {
	private int aktivnostID,vrsta_aktivnostiID;
	private String vrstaAktivnosti;
	public int getAktivnostID() {
		return aktivnostID;
	}
	public void setAktivnostID(int aktivnostID) {
		this.aktivnostID = aktivnostID;
	}
	public int getVrsta_aktivnostiID() {
		return vrsta_aktivnostiID;
	}
	public void setVrsta_aktivnostiID(int vrsta_aktivnostiID) {
		this.vrsta_aktivnostiID = vrsta_aktivnostiID;
	}
	public String getVrstaAktivnosti() {
		return vrstaAktivnosti;
	}
	public void setVrstaAktivnosti(String vrstaAktivnosti) {
		this.vrstaAktivnosti = vrstaAktivnosti;
	}
	public Vrsta_aktivnostiAktivnost(int aktivnostID, int vrsta_aktivnostiID, String vrstaAktivnosti) {
		super();
		this.aktivnostID = aktivnostID;
		this.vrsta_aktivnostiID = vrsta_aktivnostiID;
		this.vrstaAktivnosti = vrstaAktivnosti;
	}
	public Vrsta_aktivnostiAktivnost() {
		super();
		// TODO Auto-generated constructor stub
	}
}
