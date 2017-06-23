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
public class DAOAdmin {
      private DataSource ds;
      
      private static String GETHOTELIDBYUSERNAME = "SELECT hotelID FROM korisnici WHERE korisnicko_ime=?";
      private static String GETHOTELBYID = "SELECT * from hoteli WHERE hotelID=?";
      private static String UPDATEHOTELBYID = "UPDATE hoteli SET naziv=?,adresa=?,kategorija=?,broj_lezaja=?,opis=? WHERE hotelID=?";
      private static String GETKORISNICIBYHOTELID = "SELECT ime,prezime,broj_licne_karte,adresa,email,korisnicko_ime,tip_korisnika FROM korisnici WHERE hotelID = ?";
      private static String DELETEKORISNIKBYUSERNAME = "DELETE FROM korisnici WHERE korisnicko_ime=?";
      private static String GETREZERVACIJEBYHOTELID = "SELECT r.rezervacijaID,r.datum_prijavljivanja,r.datum_odlaska,r.broj_licne_karte,r.sobaID,u.vrsta_usluge FROM rezervacije r JOIN usluge u ON r.uslugaID=u.uslugaID WHERE hotelID = ?";
      private static String DELETEREZERVACIJABYID = "DELETE FROM rezervacije WHERE rezervacijaID = ?";
      
      public DAOAdmin(){
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
	
	 
	
	public int getHotelIDByUsername(String username){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Hotel hotel = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETHOTELIDBYUSERNAME);

			pstm.setString(1, username);
			pstm.execute();

			rs = pstm.getResultSet();

			if(rs.next()){ 
				hotel = new Hotel();
				hotel.setHotelID(rs.getInt("hotelID"));
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return hotel.getHotelID();
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

			if(rs.next()){ 
				hotel = new Hotel();
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
	
	public void updateHotelByID(String naziv,String adresa,int kategorija,int broj_lezaja,String opis,int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(UPDATEHOTELBYID);

			pstm.setString(1, naziv);
			pstm.setString(2, adresa);
			pstm.setInt(3, kategorija);
			pstm.setInt(4, broj_lezaja);
			pstm.setString(5, opis);
			pstm.setInt(6, hotelID);
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
	
	public ArrayList<Korisnik> getKorisnikByHotelID(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Korisnik korisnik = null;
		ArrayList<Korisnik>ls=new ArrayList<Korisnik>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETKORISNICIBYHOTELID);

			pstm.setInt(1, hotelID);
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
	
	public void deleteKorisnikByUsername(String user){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(DELETEKORISNIKBYUSERNAME);

			pstm.setString(1, user);
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
	
	public ArrayList<Hotel_Rezervacija_Usluga> getRezervacijeByHotelID(int hotelID){
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		
		Hotel_Rezervacija_Usluga rezervacije = null;
		ArrayList<Hotel_Rezervacija_Usluga>ls=new ArrayList<Hotel_Rezervacija_Usluga>();
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(GETREZERVACIJEBYHOTELID);

			pstm.setInt(1, hotelID);
			pstm.execute();

			rs = pstm.getResultSet();

			while(rs.next()){ 
				rezervacije = new Hotel_Rezervacija_Usluga();
				rezervacije.setRezervacijaID(rs.getInt("rezervacijaID"));
				rezervacije.setDatum_prijavljivanja(rs.getTimestamp("datum_prijavljivanja"));
				rezervacije.setDatum_odlaska(rs.getTimestamp("datum_odlaska"));
				rezervacije.setBroj_licne_karte(rs.getString("broj_licne_karte"));
				rezervacije.setSobaID(rs.getInt("sobaID"));
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

	public void deleteRezervacijaByID(int idr){
		Connection con = null;
		PreparedStatement pstm = null;
				
            try {
			con = ds.getConnection();
			pstm = con.prepareStatement(DELETEREZERVACIJABYID);

			pstm.setInt(1, idr);
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
