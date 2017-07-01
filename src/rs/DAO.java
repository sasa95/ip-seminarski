package rs;

import java.sql.Array;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.mysql.jdbc.Statement;

import java.util.ArrayList;
public class DAO {
      private DataSource ds;
      
      private static String MAINSEARCH = "SELECT DISTINCT (h.hotelID),h.naziv, h.adresa,h.kategorija,h.broj_lezaja from hoteli h JOIN hoteli_aktivnosti ha ON h.hotelID=ha.hotelID JOIN aktivnosti a ON ha.aktivnostID=a.aktivnostID JOIN vrste_aktivnosti va ON a.vrsta_aktivnostiID=va.vrsta_aktivnostiID JOIN hoteli_usluge hu ON h.hotelID=hu.hotelID JOIN usluge u ON hu.uslugaID=u.uslugaID WHERE h.naziv LIKE ? AND h.kategorija = COALESCE(?,h.kategorija) AND h.adresa LIKE ? AND va.naziv_vrste_aktivnosti=COALESCE(?,va.naziv_vrste_aktivnosti) AND u.vrsta_usluge=COALESCE(?,u.vrsta_usluge) ORDER BY h.hotelID";
      private static String SELECTHOTELBYID = "SELECT * FROM hoteli WHERE hotelID = ?";
      private static String SELECTBROJSOBA = "SELECT ts.naziv as nazivTipaSobe,COUNT(s.sobaID) as brojsoba FROM sobe s LEFT JOIN tipovi_soba ts ON s.tip_sobeID=ts.tip_sobeID WHERE s.hotelID = ? GROUP BY ts.naziv";
      private static String SELECTHOTELIUSLUGE = "SELECT u.vrsta_usluge AS usluga,u.cena as cena FROM usluge u JOIN hoteli_usluge hu ON u.uslugaID=hu.uslugaID WHERE hu.hotelID=?";
      private static String SELECTHOTELITRETMANI = "SELECT t.naziv as naziv from tretmani t JOIN hoteli_tretmani ht ON t.tretmanID=ht.tretmanID WHERE ht.hotelID=?";
      private static String SELECTTRZNICENTRI = "SELECT tc.naziv,tc.lokacija,tc.trzni_centarID FROM trzni_centri tc WHERE tc.hotelID=?";
      private static String SELECTPRODAVNICEBYCENTARID = "SELECT p.naziv AS nazivP,p.lokacija FROM trzni_centri tc JOIN prodavnice p ON tc.trzni_centarID=p.trzni_centarID WHERE tc.hotelID=? AND tc.trzni_centarID=?";
      private static String GETCENTARNAZIVBYCENTARID = "SELECT tc.naziv,tc.opis FROM trzni_centri tc WHERE tc.trzni_centarID=?";
      private static String SELECTVRSTEAKTIVNOSTI = "SELECT va.naziv_vrste_aktivnosti AS vrstaAktivnosti,a.aktivnostID, va.vrsta_aktivnostiID FROM vrste_aktivnosti va JOIN aktivnosti a ON va.vrsta_aktivnostiID=a.vrsta_aktivnostiID JOIN hoteli_aktivnosti ha ON a.aktivnostID=ha.aktivnostID WHERE ha.hotelID=?";
      private static String GETNAZIVVRSTEAKTIVNOSTIBYID="SELECT va.naziv_vrste_aktivnosti FROM vrste_aktivnosti va WHERE va.vrsta_aktivnostiID=?";
      private static String GETAKTIVNOSTBYID = "SELECT a.aktivnostID,a.naziv,a.opis FROM aktivnosti a JOIN hoteli_aktivnosti ha ON a.aktivnostID=ha.aktivnostID  WHERE a.vrsta_aktivnostiID=? AND ha.hotelID=?";
      private static String GETDETALJIAKTIVNOSTI = "SELECT ha.vreme_odrzavanja,ha.mesto_odrzavanja FROM hoteli_aktivnosti ha JOIN aktivnosti a ON ha.aktivnostID=a.aktivnostID WHERE ha.hotelID=? AND a.vrsta_aktivnostiID=?";
      private static String GETVRSTEAKTIVNOSTI = "SELECT naziv_vrste_aktivnosti FROM vrste_aktivnosti";
      private static String INSERTKORISNIK = "INSERT INTO korisnici (broj_licne_karte, ime, prezime, adresa, korisnicko_ime, lozinka,email) VALUES (?,?,?,?,?,?,?)";
      private static String GETKORISNIKBYUSERNAME = "SELECT broj_licne_karte,ime,prezime,adresa,email,korisnicko_ime,lozinka FROM korisnici WHERE korisnicko_ime=?";
      
      private static String GETSOBEBYHOTELIDANDTIPSOBE = "SELECT s.sobaID FROM sobe s JOIN hoteli h ON h.hotelID=s.hotelID JOIN tipovi_soba ts ON ts.tip_sobeID = s.tip_sobeID WHERE s.hotelID=? AND ts.naziv=? AND s.dostupna='da' LIMIT 1";
      private static String LOGIN = "SELECT korisnicko_ime FROM korisnici WHERE korisnicko_ime=? AND lozinka=?";
      private static String GETTIPSOBEBYHOTELID = "SELECT DISTINCT ts.naziv as naziv_tipa_sobe FROM hoteli h JOIN sobe s ON h.hotelID=s.hotelID JOIN tipovi_soba ts ON s.tip_sobeID=ts.tip_sobeID WHERE h.hotelID=? AND s.dostupna='da'";
      private static String UPDATEDOSTUPNOSTBYSOBAID = "UPDATE sobe SET dostupna='ne' WHERE sobaID=?";
      private static String INSERTREZERVACIJA = "INSERT INTO rezervacije (datum_prijavljivanja, datum_odlaska, broj_licne_karte, sobaID, hotelID, uslugaID) VALUES (?,?,?,?,?,?)";
      private static String GETUSLUGABYHOTELID = "SELECT u.vrsta_usluge,u.uslugaID FROM hoteli h JOIN hoteli_usluge hu ON h.hotelID=hu.hotelID JOIN usluge u ON hu.uslugaID=u.uslugaID WHERE h.hotelID=?";      
      private static String INSERTKORISNICIAKTIVNOSTI = "INSERT INTO korisnici_aktivnosti VALUES (?, ?)";
      private static String GETAKTIVNOSTIBYHOTELID = "SELECT a.* from hoteli h JOIN hoteli_aktivnosti ha ON h.hotelID=ha.hotelID JOIN aktivnosti a ON ha.aktivnostID=a.aktivnostID WHERE h.hotelID=?";
      private static String KORISNIKAKTIVNOST_BOOL = "SELECT * FROM korisnici_aktivnosti WHERE broj_licne_karte = ? AND aktivnostiID=?";
      private static String GETDODATAAKTIVNOST = "SELECT a.naziv,ha.datum_odrzavanja,ha.mesto_odrzavanja,ha.vreme_odrzavanja FROM korisnici k join korisnici_aktivnosti ka ON k.broj_licne_karte=ka.broj_licne_karte JOIN aktivnosti a ON ka.aktivnostiID=a.aktivnostID JOIN hoteli_aktivnosti ha ON a.aktivnostID=ha.aktivnostID WHERE k.broj_licne_karte=?";
      private static String GETREZERVACIJABYKORISNICKOIME = "SELECT h.naziv,r.sobaID,r.datum_prijavljivanja,r.datum_odlaska,r.broj_licne_karte,U.vrsta_usluge FROM rezervacije r JOIN korisnici k ON r.broj_licne_karte=k.broj_licne_karte JOIN hoteli h ON r.hotelID=h.hotelID LEFT JOIN usluge u ON r.uslugaID=u.uslugaID WHERE k.korisnicko_ime=?";  
      private static String ADMINHOTELA_BOOL = "SELECT korisnicko_ime,broj_licne_karte FROM korisnici WHERE korisnicko_ime=? AND lozinka=? AND tip_korisnika='admin_hotela'";
      private static String UPDATEKORISNIKBYUSERNAME = "UPDATE korisnici SET broj_licne_karte=?,ime=?,prezime=?,adresa=?,lozinka=?,email=? WHERE korisnicko_ime=?";
      
      public DAO(){
	try {
		InitialContext cxt = new InitialContext();
		if ( cxt == null ) { 
		} 
		ds = (DataSource) cxt.lookup( "java:/comp/env/jdbc/mysql" ); 
		if ( ds == null ) { 
		} 		
		} catch (NamingException e) {
		}
	} 
	// DEFINICIJA METODE 
	
	 
	public Hotel selectHotelByID(int id){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		// POMOCNE PROMENLJIVE ZA KONKRETNU METODU 
		Hotel hotel = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SELECTHOTELBYID);

			// DOPUNJAVANJE SQL STRINGA, SVAKI ? SE MORA PODESITI 
			pstm.setInt(1, id);
			pstm.execute();

//****POCETAK AKO UPIT VRACA REZULTAT TREBA SLEDECI DEO 
			rs = pstm.getResultSet();

			while(rs.next()){ // if UMESTO while AKO UPIT VRACA JEDAN REZULTAT
				// KREIRANJE INSTANCE KLASE PREKO PODRAZUMEVANOG KONSTRUKTORA
				hotel = new Hotel();
				// SET-OVANJE SVIH ATRIBUTA KLASE SA ODGOVARAJUCIM VREDNOSTIMA IZ RESULTSET-A rs
				hotel.setHotelID(rs.getInt("hotelID"));
				hotel.setNaziv(rs.getString("naziv"));
				hotel.setAdresa(rs.getString("adresa"));
				hotel.setKategorija(rs.getInt("kategorija"));
				hotel.setBroj_lezaja(rs.getInt("broj_lezaja"));
				hotel.setOpis(rs.getString("opis"));
				
				
			
				// DODAVANJE INSTANCE U LISTU AKO METODA VRACA LISTU, AKO NE VRACA ONDA NE TREBA 
				
			}
//****KRAJ OBRADE ResultSet-a	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// VRACANJE REZULTATA AKO METODA VRACA REZULTAT
		return hotel; 
	}
	
	public ArrayList<SobaTip_sobe> brojSoba(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		SobaTip_sobe sobe = null;
		ArrayList<SobaTip_sobe>ls=new ArrayList<SobaTip_sobe>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SELECTBROJSOBA);

			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				sobe = new SobaTip_sobe();
				sobe.setNazivTipaSobe(rs.getString("nazivTipaSobe"));
				sobe.setBrojSoba(rs.getInt("brojsoba"));
				
				ls.add(sobe);
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ls;
	}
	
	public ArrayList<Usluga> selectHoteliUsluge(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		ArrayList<Usluga> lo = new ArrayList<Usluga>();
		Usluga usluga = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SELECTHOTELIUSLUGE);

			
			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				usluga = new Usluga();
				usluga.setVrsta_usluge(rs.getString("usluga"));
				usluga.setCena(rs.getFloat("cena"));
			
				lo.add(usluga);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}
	
	public ArrayList<Tretman> selectHoteliTretmani(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		ArrayList<Tretman> lo = new ArrayList<Tretman>();
		Tretman tretman = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SELECTHOTELITRETMANI);

			
			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				tretman = new Tretman();
				tretman.setNaziv(rs.getString("naziv"));
			
				lo.add(tretman);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}
	
	public ArrayList<Trzni_centar> selectTrzniCentar(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		ArrayList<Trzni_centar> lo = new ArrayList<Trzni_centar>();
		Trzni_centar trznicentar = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SELECTTRZNICENTRI);

			
			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				trznicentar = new Trzni_centar();
				trznicentar.setNaziv(rs.getString("naziv"));
				trznicentar.setLokacija(rs.getString("lokacija"));
				trznicentar.setTrzni_centarID(rs.getInt("trzni_centarID"));
				lo.add(trznicentar);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}

	public ArrayList<Trzni_centar_prodavnica> selectProdavniceByCentarId(int hotelID,int centarID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		ArrayList<Trzni_centar_prodavnica> lo = new ArrayList<Trzni_centar_prodavnica>();
		Trzni_centar_prodavnica tcp = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SELECTPRODAVNICEBYCENTARID);

			pstm.setInt(1, hotelID);
			pstm.setInt(2, centarID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				tcp = new Trzni_centar_prodavnica();
				tcp.setNazivProdavnice(rs.getString("nazivP"));
				tcp.setLokacija(rs.getString("lokacija"));
				
				lo.add(tcp);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}
	
	public Trzni_centar getCentarNazivByCentarID(int centarID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		Trzni_centar tc = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETCENTARNAZIVBYCENTARID);

			pstm.setInt(1, centarID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				tc = new Trzni_centar();
				tc.setNaziv(rs.getString("naziv"));
				tc.setOpis(rs.getString("opis"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return tc; 
	}
	
	public ArrayList<Vrsta_aktivnostiAktivnost> selectVrsteAktivnosti(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		ArrayList<Vrsta_aktivnostiAktivnost> lo = new ArrayList<Vrsta_aktivnostiAktivnost>();
		Vrsta_aktivnostiAktivnost va = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SELECTVRSTEAKTIVNOSTI);

			
			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				va = new Vrsta_aktivnostiAktivnost();
				va.setAktivnostID(rs.getInt("aktivnostID"));
				va.setVrsta_aktivnostiID(rs.getInt("vrsta_aktivnostiID"));
				va.setVrstaAktivnosti(rs.getString("vrstaAktivnosti"));
			
				lo.add(va);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}
	
	public Vrsta_aktivnosti getVrstaAktivnostiByID(int aktivnostID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		Vrsta_aktivnosti vaID = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETNAZIVVRSTEAKTIVNOSTIBYID);

			
			pstm.setInt(1, aktivnostID);
			pstm.execute();

			rs = pstm.getResultSet();

			if(rs.next()){
				vaID = new Vrsta_aktivnosti();
				vaID.setNaziv_vrste_aktivnosti(rs.getString("naziv_vrste_aktivnosti"));
	
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return vaID; 
	}
	
	public ArrayList<Aktivnost> getAktivnostByID(int aktivnostID,int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		ArrayList<Aktivnost> lo = new ArrayList<Aktivnost>();
		Aktivnost akt = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETAKTIVNOSTBYID);

			
			pstm.setInt(1, aktivnostID);
			pstm.setInt(2, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				akt = new Aktivnost();
				akt.setAktivnostID(rs.getInt("aktivnostID"));
				akt.setNaziv(rs.getString("naziv"));
				akt.setOpis(rs.getString("opis"));
				
				lo.add(akt);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}
	
	public ArrayList<Hotel_aktivnost> getDetaljiAktivnosti(int hotelID,int aktivnostID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		ArrayList<Hotel_aktivnost> lo = new ArrayList<Hotel_aktivnost>();
		Hotel_aktivnost ha = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETDETALJIAKTIVNOSTI);

			pstm.setInt(1, hotelID);
			pstm.setInt(2, aktivnostID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				ha = new Hotel_aktivnost();
				ha.setVreme_odrzavanja(rs.getTimestamp("vreme_odrzavanja"));
				ha.setMesto_odrzavanja(rs.getString("mesto_odrzavanja"));
				//ha.setHotelID(rs.getInt("hotelID"));
				//ha.setAktivnostID(rs.getInt("vrsta_aktivnostiID"));
				lo.add(ha);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}
	
	public ArrayList<Hotel> mainSearch(String naziv,String kategorije, String adresa, String vrsta_aktivnosti, String vrsta_usluge ){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		ArrayList<Hotel> lo = new ArrayList<Hotel>();
		Hotel hoteli = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(MAINSEARCH);

			pstm.setString(1, "%" +naziv +"%");
			pstm.setString(2, kategorije);
			pstm.setString(3, "%" +adresa +"%");
			pstm.setString(4, vrsta_aktivnosti);
			pstm.setString(5, vrsta_usluge);

			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				hoteli = new Hotel();
				hoteli.setHotelID(rs.getInt("hotelID"));
				hoteli.setNaziv(rs.getString("naziv"));
				hoteli.setAdresa(rs.getString("adresa"));
				hoteli.setKategorija(rs.getInt("kategorija"));
				hoteli.setBroj_lezaja(rs.getInt("broj_lezaja"));
				lo.add(hoteli);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}
	
	public ArrayList<Vrsta_aktivnosti> getVrsteAktivnosti(){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		ArrayList<Vrsta_aktivnosti> lo = new ArrayList<Vrsta_aktivnosti>();
		Vrsta_aktivnosti aktivnosti = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETVRSTEAKTIVNOSTI);

			
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				aktivnosti = new Vrsta_aktivnosti();
				aktivnosti.setNaziv_vrste_aktivnosti(rs.getString("naziv_vrste_aktivnosti"));
				lo.add(aktivnosti);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}

	public void insertKorisnik(String broj_licne_karte,String ime,String prezime,String adresa,String korisnicko_ime,String lozinka1,String email){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(INSERTKORISNIK);

			pstm.setString(1, broj_licne_karte);
			pstm.setString(2, ime);
			pstm.setString(3, prezime);
			pstm.setString(4, adresa);
			pstm.setString(5, korisnicko_ime);
			pstm.setString(6, lozinka1);
			pstm.setString(7, email);

			pstm.execute();



		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public boolean login(String username,String password){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		ArrayList<Korisnik>korisnik=new ArrayList<Korisnik>();
		Korisnik k = new Korisnik();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(LOGIN);

			pstm.setString(1, username);
			pstm.setString(2, password);

			pstm.execute();
			
			rs = pstm.getResultSet();

			while(rs.next()){
				k.setKorisnicko_ime(rs.getString("korisnicko_ime"));
				korisnik.add(k);
			}


		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(korisnik.size()>0)
			return true;
		else
			return false;
		
	}

	public Korisnik getKorisnikByUsername(String korisnicko_ime){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		// POMOCNE PROMENLJIVE ZA KONKRETNU METODU 
		Korisnik korisnik = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETKORISNIKBYUSERNAME);

			// DOPUNJAVANJE SQL STRINGA, SVAKI ? SE MORA PODESITI 
			pstm.setString(1, korisnicko_ime);
			pstm.execute();

//****POCETAK AKO UPIT VRACA REZULTAT TREBA SLEDECI DEO 
			rs = pstm.getResultSet();

			if(rs.next()){ // if UMESTO while AKO UPIT VRACA JEDAN REZULTAT
				// KREIRANJE INSTANCE KLASE PREKO PODRAZUMEVANOG KONSTRUKTORA
				korisnik = new Korisnik();
				// SET-OVANJE SVIH ATRIBUTA KLASE SA ODGOVARAJUCIM VREDNOSTIMA IZ RESULTSET-A rs
				korisnik.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				korisnik.setIme(rs.getString("ime"));
				korisnik.setPrezime(rs.getString("prezime"));
				korisnik.setAdresa(rs.getString("adresa"));
				korisnik.setEmail(rs.getString("email"));
				korisnik.setKorisnicko_ime(rs.getString("korisnicko_ime"));
				korisnik.setLozinka(rs.getString("lozinka"));
			
				// DODAVANJE INSTANCE U LISTU AKO METODA VRACA LISTU, AKO NE VRACA ONDA NE TREBA 
				
			}
//****KRAJ OBRADE ResultSet-a	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// VRACANJE REZULTATA AKO METODA VRACA REZULTAT
		return korisnik; 
	}

	public int getSobaByHotelIdAndTipSobe(int hotelID,String tip_sobe){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Soba soba = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETSOBEBYHOTELIDANDTIPSOBE);
			
			pstm.setInt(1, hotelID);
			pstm.setString(2, tip_sobe);

			pstm.execute();
			rs = pstm.getResultSet();
			
			while(rs.next()){
				soba = new Soba();
				soba.setSobaID(rs.getInt("sobaID"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return soba.getSobaID(); 
	}
	
	public ArrayList<Tip_sobe> getTipSobeByHotelID(String hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		ArrayList<Tip_sobe> lo = new ArrayList<Tip_sobe>();
		Tip_sobe tip = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETTIPSOBEBYHOTELID);
			pstm.setString(1, hotelID);
			
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				tip = new Tip_sobe();
				tip.setNaziv(rs.getString("naziv_tipa_sobe"));
				lo.add(tip);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}

	public void updateDostupnostBySobaId(int sobaID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		// POMOCNE PROMENLJIVE ZA KONKRETNU METODU 
		Soba soba = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(UPDATEDOSTUPNOSTBYSOBAID);

			// DOPUNJAVANJE SQL STRINGA, SVAKI ? SE MORA PODESITI 
			pstm.setInt(1, sobaID);
			pstm.execute();

//****POCETAK AKO UPIT VRACA REZULTAT TREBA SLEDECI DEO 

				// DODAVANJE INSTANCE U LISTU AKO METODA VRACA LISTU, AKO NE VRACA ONDA NE TREBA 
				
			
//****KRAJ OBRADE ResultSet-a	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
	public void insertRezervacija(Timestamp datum_prijavljivanja,Timestamp datum_odlaska,String broj_licne_karte,int sobaID,int hotelID,int uslugaID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(INSERTREZERVACIJA);

			pstm.setTimestamp(1, datum_prijavljivanja);
			pstm.setTimestamp(2, datum_odlaska);
			pstm.setString(3, broj_licne_karte);
			pstm.setInt(4, sobaID);
			pstm.setInt(5, hotelID);
			pstm.setInt(6, uslugaID);

			pstm.execute();


		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<Usluga> getUslugaByHotelID(String hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Usluga usluge = null;
		ArrayList<Usluga>ls=new ArrayList<Usluga>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETUSLUGABYHOTELID);

			pstm.setString(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				usluge = new Usluga();
				usluge.setVrsta_usluge(rs.getString("vrsta_usluge"));
				usluge.setUslugaID(rs.getInt("uslugaID"));
				ls.add(usluge);
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ls;
	}

	
	
	public void insertKorisniciAktivnosti(String broj_licne_karte, int aktivnostID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(INSERTKORISNICIAKTIVNOSTI);

			pstm.setString(1, broj_licne_karte);
			pstm.setInt(2, aktivnostID);
			

			pstm.execute();



		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<Aktivnost> getAktivnostByHotelID(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Aktivnost akt = null;
		ArrayList<Aktivnost>ls=new ArrayList<Aktivnost>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETAKTIVNOSTIBYHOTELID);

			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				akt = new Aktivnost();
				akt.setAktivnostID(rs.getInt("aktivnostID"));
				akt.setNaziv(rs.getString("naziv"));
				akt.setOpis(rs.getString("opis"));
				akt.setVrsta_aktivnostiID(rs.getInt("vrsta_aktivnostiID"));
				
				ls.add(akt);
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ls;
	}
	
	public boolean korisnikAktivnost_bool(String lk, int aktID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Korisnici_aktivnosti akt = null;
		ArrayList<Korisnici_aktivnosti>ls=new ArrayList<Korisnici_aktivnosti>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(KORISNIKAKTIVNOST_BOOL);

			pstm.setString(1, lk);
			pstm.setInt(2, aktID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				akt = new Korisnici_aktivnosti();
				akt.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				akt.setAktivnostiID(rs.getInt("aktivnostiID"));
				
				ls.add(akt);
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(ls.size()>0)
			return true;
		else
			return false;
	}
	
	public ArrayList<Hotel_aktivnost> getDodataAktivnost(String lk){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Hotel_aktivnost akt = null;
		ArrayList<Hotel_aktivnost>ls=new ArrayList<Hotel_aktivnost>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETDODATAAKTIVNOST);

			pstm.setString(1, lk);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				akt = new Hotel_aktivnost();
				akt.setNaziv(rs.getString("naziv"));
				akt.setDatum_odrzavanja(rs.getDate("datum_odrzavanja"));
				akt.setMesto_odrzavanja(rs.getString("mesto_odrzavanja"));
				akt.setVreme_odrzavanja(rs.getTimestamp("vreme_odrzavanja"));
				ls.add(akt);
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ls;
	}
	
	public ArrayList<Hotel_Rezervacija_Usluga> getRezervacijaByKorisnickoIme(String korisnicko_ime){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		ArrayList<Hotel_Rezervacija_Usluga> lo = new ArrayList<Hotel_Rezervacija_Usluga>();
		Hotel_Rezervacija_Usluga hru = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETREZERVACIJABYKORISNICKOIME);
			pstm.setString(1, korisnicko_ime);
			
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){
				hru = new Hotel_Rezervacija_Usluga();
				hru.setNaziv(rs.getString("naziv"));
				hru.setSobaID(rs.getInt("sobaID"));
				hru.setDatum_prijavljivanja(rs.getDate("datum_prijavljivanja"));
				hru.setDatum_odlaska(rs.getDate("datum_odlaska"));
				hru.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				hru.setVrsta_usluge(rs.getString("vrsta_usluge"));

				lo.add(hru);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return lo; 
	}
	
	public boolean loginAdmin(String username,String password){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		ArrayList<Korisnik>korisnik=new ArrayList<Korisnik>();
		Korisnik k = new Korisnik();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(ADMINHOTELA_BOOL);

			pstm.setString(1, username);
			pstm.setString(2, password);

			pstm.execute();
			
			rs = pstm.getResultSet();

			while(rs.next()){
				k.setKorisnicko_ime(rs.getString("korisnicko_ime"));
				k.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				korisnik.add(k);
			}


		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(korisnik.size()>0)
			return true;
		else
			return false;
	}
	
	public void updateKorisnikByUsername(String broj_l_k,String ime,String prezime,String adresa,String lozinka,String email,String username){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(UPDATEKORISNIKBYUSERNAME);

			pstm.setString(1, broj_l_k);
			pstm.setString(2, ime);
			pstm.setString(3, prezime);
			pstm.setString(4, adresa);
			pstm.setString(5, lozinka);
			pstm.setString(6, email);
			pstm.setString(7,username);
			pstm.execute();


		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
