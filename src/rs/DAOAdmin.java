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
	
}
