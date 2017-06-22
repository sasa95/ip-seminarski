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
	
}
