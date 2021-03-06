package rs;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Servlet_rezervacija")
public class Servlet_rezervacija extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public Servlet_rezervacija() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hotelID = request.getParameter("hotelID");
		DAO dao = new DAO();
		HttpSession loginSesija = request.getSession();
		
		if(loginSesija.getAttribute("username")!=null){
			ArrayList<Usluga>lsusl = dao.getUslugaByHotelID(hotelID);
			ArrayList<Tip_sobe>lsts = dao.getTipSobeByHotelID(hotelID);
			
			
			loginSesija.setAttribute("lsusl", lsusl);
			loginSesija.setAttribute("lsts", lsts);
			request.getRequestDispatcher("rezervacija.jsp?hotelID="+hotelID).forward(request, response);
		}
		else {
			response.sendRedirect("prijava.jsp");
		}
		
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String akcija = request.getParameter("akcija");
		HttpSession loginSesija = request.getSession();
		String username = (String)loginSesija.getAttribute("username");
		DAO dao = new DAO();

		if(akcija.equals("Rezervisi")) {
			String datum_prijavljivanja = request.getParameter("datum_prijavljivanja");
			String datum_odlaska = request.getParameter("datum_odlaska");
			String broj_licne_karte = request.getParameter("broj_licne_karte");
			String uslugaID = request.getParameter("uslugaID");
					
			if(datum_prijavljivanja!=null && datum_prijavljivanja.trim().length()>0){
				String hotelID = request.getParameter("hotelID");
				String tip_sobe = request.getParameter("tip_sobe");
				
				int id = Integer.parseInt(hotelID);
				
				int s_id = dao.getSobaByHotelIdAndTipSobe(id, tip_sobe);
				int u_id = Integer.parseInt(uslugaID);
				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				
				try {
					Date parsedDate = dateFormat.parse(datum_prijavljivanja);
					Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
					if(datum_odlaska.equals("")==false){
						Date parsedDate_o = dateFormat.parse(datum_odlaska);
						Timestamp timestamp_o = new java.sql.Timestamp(parsedDate_o.getTime());
						dao.insertRezervacija(timestamp, timestamp_o, broj_licne_karte, s_id, id, u_id);
					}
					
					else {
						dao.insertRezervacija(timestamp, null, broj_licne_karte, s_id, id, u_id);
						
					}
					dao.updateDostupnostBySobaId(s_id);
					ArrayList<Hotel_Rezervacija_Usluga> lsrez = dao.getRezervacijaByKorisnickoIme(username);
					loginSesija.setAttribute("lsrez", lsrez);
					
					String fullString = (String)loginSesija.getAttribute("fullString");
					
					request.setAttribute("msg", "Uspesna rezervacija");
					request.getRequestDispatcher(fullString).forward(request, response);
					
				} 
				
				catch (ParseException e) {
					e.printStackTrace();
				}
			}
			
			else {
				request.setAttribute("msg", "Morate popuniti datum prijavljivanja.");
				request.getRequestDispatcher("rezervacija.jsp?"+loginSesija.getAttribute("parametri")).forward(request, response);
			}
		
		}
	}
}
