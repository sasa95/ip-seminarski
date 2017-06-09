package rs;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.util.ArrayList;
public class DAO {
      private DataSource ds;

      private static String SELECTHOTELI = "SELECT * FROM hoteli WHERE naziv LIKE ?";
      private static String SELECTHOTELBYID = "SELECT * FROM hoteli WHERE hotelID = ?";
      private static String SELECTBROJSOBA = "SELECT ts.naziv as nazivTipaSobe,COUNT(s.sobaID) as brojsoba FROM sobe s LEFT JOIN tipovi_soba ts ON s.tip_sobeID=ts.tip_sobeID WHERE s.hotelID = ? GROUP BY ts.naziv";
      private static String SELECTHOTELIUSLUGE = "SELECT u.vrsta_usluge AS usluga,u.cena as cena FROM usluge u JOIN hoteli_usluge hu ON u.uslugaID=hu.uslugaID WHERE hu.hotelID=?";
      private static String SELECTHOTELITRETMANI = "SELECT t.naziv as naziv from tretmani t JOIN hoteli_tretmani ht ON t.tretmanID=ht.tretmanID WHERE ht.hotelID=?";
      private static String SELECTTRZNICENTRI = "SELECT tc.naziv,tc.lokacija,tc.trzni_centarID FROM trzni_centri tc WHERE tc.hotelID=?";
      private static String SELECTPRODAVNICEBYCENTARID = "SELECT p.naziv AS nazivP,p.lokacija FROM trzni_centri tc JOIN prodavnice p ON tc.trzni_centarID=p.trzni_centarID WHERE tc.hotelID=? AND tc.trzni_centarID=?";
      private static String GETCENTARNAZIVBYCENTARID = "SELECT tc.naziv,tc.opis FROM trzni_centri tc WHERE tc.trzni_centarID=?";
      
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
	public ArrayList<Hotel> selectHoteli(String naziv){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
	
		ArrayList<Hotel> lo = new ArrayList<Hotel>();
		Hotel hoteli = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(SELECTHOTELI);

			
			pstm.setString(1, "%" +naziv +"%");
			pstm.execute();


			rs = pstm.getResultSet();

			while(rs.next()){ 
				hoteli = new Hotel();
				hoteli.setHotelID(rs.getInt("hotelID"));
				hoteli.setNaziv(rs.getString("naziv"));
				hoteli.setAdresa(rs.getString("adresa"));
				hoteli.setKategorija(rs.getInt("kategorija"));
				hoteli.setBroj_lezaja(rs.getInt("broj_lezaja"));
				hoteli.setOpis(rs.getString("opis"));
			
				
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
}
