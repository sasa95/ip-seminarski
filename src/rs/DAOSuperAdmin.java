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

import org.apache.catalina.User;

import com.mysql.jdbc.Statement;

import javafx.geometry.Pos;

import java.util.ArrayList;
public class DAOSuperAdmin {
      private DataSource ds;
      
      private static String LOGIN = "SELECT * FROM admini_sajta WHERE username=? AND password=?";
      
      private static String GETHOTELI = "SELECT hotelID,naziv,adresa,kategorija,broj_lezaja,CONCAT(SUBSTRING(opis,1,50),'...') as opis FROM hoteli";
      private static String GETHOTELBYID = "SELECT * FROM hoteli WHERE hotelID=?";
      private static String GETHOTELID = "SELECT hotelID,naziv FROM hoteli";
      private static String INSERTHOTEL = "INSERT INTO hoteli(naziv, adresa, kategorija, broj_lezaja, opis) VALUES (?,?,?,?,?)";
      private static String UPDATEHOTELBYID = "UPDATE hoteli SET naziv=?,adresa=?,kategorija=?,broj_lezaja=?,opis=? WHERE hotelID=?";
      private static String DELETEHOTELBYID = "DELETE FROM hoteli WHERE hotelID=?";
      
      private static String GETKORISNICI = "SELECT * FROM korisnici ORDER BY tip_korisnika";
      private static String GETKORISNIKBYUSERNAME = "SELECT * FROM korisnici WHERE korisnicko_ime=?";
      private static String INSERTKORISNIK = "INSERT INTO korisnici(broj_licne_karte,ime,prezime,adresa,email,korisnicko_ime,lozinka,tip_korisnika, hotelID) VALUES (?,?,?,?,?,?,?,'admin_hotela',?)";
      private static String UPDATEKORISNIKBYUSERNAME = "UPDATE korisnici SET broj_licne_karte=?,ime=?,prezime=?,adresa=?,email=?,korisnicko_ime=?,lozinka=?,tip_korisnika='admin_hotela',hotelID=? WHERE korisnicko_ime=?";
      private static String DELETEKORISNIKBYUSERNAME = "DELETE FROM korisnici WHERE korisnicko_ime=?";
      
      private static String GETREZERVACIJE = "SELECT r.rezervacijaID, h.naziv, r.datum_prijavljivanja,r.datum_odlaska,r.broj_licne_karte,r.sobaID,u.vrsta_usluge FROM rezervacije r JOIN sobe s ON r.sobaID=s.sobaID JOIN hoteli h ON s.hotelID=h.hotelID JOIN usluge u ON r.uslugaID=u.uslugaID";
      private static String GETREZERVACIJEBYHOTELID = "SELECT r.rezervacijaID, h.naziv, r.datum_prijavljivanja,r.datum_odlaska,r.broj_licne_karte,r.sobaID,u.vrsta_usluge FROM rezervacije r JOIN sobe s ON r.sobaID=s.sobaID JOIN hoteli h ON s.hotelID=h.hotelID JOIN usluge u ON r.uslugaID=u.uslugaID WHERE h.hotelID=?";
      
      public DAOSuperAdmin(){
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
      
      public boolean superLogin(String username,String password){
  		Connection con = null;
  		PreparedStatement pstm = null;
  		ResultSet rs = null;
  		ArrayList<Admin_sajta>ls=new ArrayList<Admin_sajta>();
  		Admin_sajta admin = new Admin_sajta();
  				
              try {
  			con = ds.getConnection();
  			pstm = con.prepareStatement(LOGIN);

  			pstm.setString(1, username);
  			pstm.setString(2, password);

  			pstm.execute();
  			
  			rs = pstm.getResultSet();

  			while(rs.next()){
  				admin.setUsername(rs.getString("username"));
  				admin.setPassword(rs.getString("password"));
  				admin.setAdminID(rs.getInt("adminID"));
  				ls.add(admin);
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
	
      public ArrayList<Hotel> getHoteli(){
  		Connection con = null;
  		PreparedStatement pstm = null;
  		ResultSet rs = null;
  		ArrayList<Hotel>ls = new ArrayList<Hotel>();
  		Hotel hotel = null;
  				
              try {
  			con = ds.getConnection();
  			pstm = con.prepareStatement(GETHOTELI);

  			pstm.execute();

  			rs = pstm.getResultSet();

  			while(rs.next()){ 
  				hotel = new Hotel();
  				hotel.setHotelID(rs.getInt("hotelID"));
  				hotel.setNaziv(rs.getString("naziv"));
  				hotel.setAdresa(rs.getString("adresa"));
  				hotel.setKategorija(rs.getInt("kategorija"));
  				hotel.setBroj_lezaja(rs.getInt("broj_lezaja"));
  				hotel.setOpis(rs.getString("opis"));
  				
  				ls.add(hotel);
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
      
  public Hotel getHotelByID(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Hotel hotel = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETHOTELBYID);

			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				hotel = new Hotel();
				hotel.setHotelID(rs.getInt("hotelID"));
				hotel.setNaziv(rs.getString("naziv"));
				hotel.setAdresa(rs.getString("adresa"));
				hotel.setKategorija(rs.getInt("kategorija"));
				hotel.setBroj_lezaja(rs.getInt("broj_lezaja"));
				hotel.setOpis(rs.getString("opis"));
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return hotel;
	}
  
  public ArrayList<Hotel> getHotelID(){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		ArrayList<Hotel>ls=new ArrayList<Hotel>();
		Hotel hotel = null;
				
          try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETHOTELID);

			
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				hotel = new Hotel();
				hotel.setHotelID(rs.getInt("hotelID"));
				hotel.setNaziv(rs.getString("naziv"));
				ls.add(hotel);
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
      
	public void insertHotel(String naziv,String adresa,int kategorija,int br_lezaja,String opis){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(INSERTHOTEL);

			pstm.setString(1, naziv);
			pstm.setString(2, adresa);
			pstm.setInt(3, kategorija);
			pstm.setInt(4,br_lezaja);
			pstm.setString(5, opis);
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
	
	public void updateHotelByID(String naziv,String adresa,int kategorija,int br_lezaja,String opis,int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(UPDATEHOTELBYID);

			pstm.setString(1, naziv);
			pstm.setString(2, adresa);
			pstm.setInt(3, kategorija);
			pstm.setInt(4,br_lezaja);
			pstm.setString(5, opis);
			pstm.setInt(6,hotelID);
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
	
	public void deleteHotelByID(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(DELETEHOTELBYID);

			pstm.setInt(1,hotelID);
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
	
	public ArrayList<Korisnik> getKorisnici(){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Korisnik korisnik = null;
		ArrayList<Korisnik>ls=new ArrayList<Korisnik>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETKORISNICI);

			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				korisnik = new Korisnik();
				korisnik.setIme(rs.getString("ime"));
				korisnik.setPrezime(rs.getString("prezime"));
				korisnik.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				korisnik.setAdresa(rs.getString("adresa"));
				korisnik.setEmail(rs.getString("email"));
				korisnik.setKorisnicko_ime(rs.getString("korisnicko_ime"));
				korisnik.setTip_korisnika(rs.getString("tip_korisnika"));
				korisnik.setLozinka(rs.getString("lozinka"));
				korisnik.setHotelID(rs.getInt("hotelID"));
				
				ls.add(korisnik);
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
	
	public Korisnik getKorisnikByUsername(String username){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Korisnik korisnik = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETKORISNIKBYUSERNAME);
			
			pstm.setString(1, username);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				korisnik = new Korisnik();
				korisnik.setIme(rs.getString("ime"));
				korisnik.setPrezime(rs.getString("prezime"));
				korisnik.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				korisnik.setAdresa(rs.getString("adresa"));
				korisnik.setEmail(rs.getString("email"));
				korisnik.setKorisnicko_ime(rs.getString("korisnicko_ime"));
				korisnik.setTip_korisnika(rs.getString("tip_korisnika"));
				korisnik.setLozinka(rs.getString("lozinka"));
				korisnik.setHotelID(rs.getInt("hotelID"));
				
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return korisnik;
	}
	
	public void insertKorisnik(String br_lk,String ime,String prezime,String adresa,String email,String korisnicko_ime,String lozinka,String hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(INSERTKORISNIK);

			pstm.setString(1, br_lk);
			pstm.setString(2, ime);
			pstm.setString(3, prezime);
			pstm.setString(4, adresa);
			pstm.setString(5, email);
			pstm.setString(6, korisnicko_ime);
			pstm.setString(7, lozinka);
			pstm.setString(8, hotelID);
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
	
	public void updateKorisnikByUsername(String br_lk,String ime,String prezime,String adresa,String email,String korisnicko_ime,String lozinka,int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(UPDATEKORISNIKBYUSERNAME);

			pstm.setString(1, br_lk);
			pstm.setString(2, ime);
			pstm.setString(3, prezime);
			pstm.setString(4, adresa);
			pstm.setString(5, email);
			pstm.setString(6, korisnicko_ime);
			pstm.setString(7, lozinka);
			pstm.setInt(8, hotelID);
			pstm.setString(9, korisnicko_ime);
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
	
	public void deleteKorisnikByUsername(String username){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(DELETEKORISNIKBYUSERNAME);

			pstm.setString(1,username);
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
	
	public ArrayList<Hotel_Rezervacija_UslugaDATE> getRezervacije(){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Hotel_Rezervacija_UslugaDATE rezervacije = null;
		ArrayList<Hotel_Rezervacija_UslugaDATE>ls=new ArrayList<Hotel_Rezervacija_UslugaDATE>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETREZERVACIJE);

			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				rezervacije = new Hotel_Rezervacija_UslugaDATE();
				rezervacije.setRezervacijaID(rs.getInt("rezervacijaID"));
				rezervacije.setDatum_prijavljivanja(rs.getDate("datum_prijavljivanja"));
				rezervacije.setDatum_odlaska(rs.getDate("datum_odlaska"));
				rezervacije.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				rezervacije.setSobaID(rs.getInt("sobaID"));
				rezervacije.setNaziv(rs.getString("naziv"));
				rezervacije.setVrsta_usluge(rs.getString("vrsta_usluge"));
	
				
				ls.add(rezervacije);
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
	
	public ArrayList<Hotel_Rezervacija_UslugaDATE> getRezervacijeByHotelID(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Hotel_Rezervacija_UslugaDATE rezervacije = null;
		ArrayList<Hotel_Rezervacija_UslugaDATE>ls=new ArrayList<Hotel_Rezervacija_UslugaDATE>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETREZERVACIJEBYHOTELID);

			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				rezervacije = new Hotel_Rezervacija_UslugaDATE();
				rezervacije.setRezervacijaID(rs.getInt("rezervacijaID"));
				rezervacije.setDatum_prijavljivanja(rs.getDate("datum_prijavljivanja"));
				rezervacije.setDatum_odlaska(rs.getDate("datum_odlaska"));
				rezervacije.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				rezervacije.setSobaID(rs.getInt("sobaID"));
				rezervacije.setNaziv(rs.getString("naziv"));
				rezervacije.setVrsta_usluge(rs.getString("vrsta_usluge"));	
				
				ls.add(rezervacije);
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
}
