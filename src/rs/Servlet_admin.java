package rs;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/Servlet_admin")
public class Servlet_admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public Servlet_admin() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String akcija = request.getParameter("akcija");
		DAOAdmin daoAdmin = new DAOAdmin();
		HttpSession adminSesija = request.getSession();
		int hot_id = (Integer)adminSesija.getAttribute("hot_id");
		if(akcija.equals("logout")){
			adminSesija.invalidate();
			response.sendRedirect("index.jsp");
		}
		
		else if(akcija.equals("hotelDetalji")){
			Hotel hotel = daoAdmin.getHotelByID(hot_id);
			request.setAttribute("hotel", hotel);
			request.getRequestDispatcher("adminHotelDetalji.jsp").forward(request, response);
		}
		
		else if(akcija.equals("korisniciTabela")){
			Hotel hotel = daoAdmin.getHotelByID(hot_id);
			request.setAttribute("hotel", hotel);
			ArrayList<Korisnik>korisnici = daoAdmin.getKorisnikByHotelID(hot_id);
			request.setAttribute("korisnici", korisnici);
			request.getRequestDispatcher("adminKorisnici.jsp").forward(request, response);
		}
		
		else if(akcija.equals("obrisiKorisnika")){
			String user = request.getParameter("user");
			daoAdmin.deleteKorisnikByUsername(user);
			response.sendRedirect("Servlet_admin?akcija=korisniciTabela&hotelID="+hot_id+"&status=ok");
		}
		
		else if(akcija.equals("rezervacijeTabela")){
			ArrayList<Hotel_Rezervacija_Usluga> rezervacije = daoAdmin.getRezervacijeByHotelID(hot_id);
			Hotel hotel = daoAdmin.getHotelByID(hot_id);
			request.setAttribute("rezervacije", rezervacije);
			request.setAttribute("hotel", hotel);
			request.getRequestDispatcher("adminRezervacije.jsp").forward(request, response);
		}
		
		else if(akcija.equals("obrisiRezervaciju")){
			String rezervacijaID = request.getParameter("rezervacijaID");
			try {
				int rid = Integer.parseInt(rezervacijaID);
				daoAdmin.deleteRezervacijaByID(rid);
				response.sendRedirect("Servlet_admin?akcija=rezervacijeTabela&hotelID="+hot_id+"&status=ok");
			}
			
			catch(Exception e){
				response.sendRedirect("error.jsp");
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String akcija = request.getParameter("akcija");
		DAOAdmin daoAdmin = new DAOAdmin();
		if(akcija.equals("izmeniHotel")){
			String hotelID = request.getParameter("hotelID");
			String naziv = request.getParameter("naziv");
			String adresa = request.getParameter("adresa");
			String kategorija = request.getParameter("kategorija");
			String broj_lezaja = request.getParameter("broj_lezaja");
			String opis = request.getParameter("opis");
			String returnPath = request.getParameter("returnPath");
			
			try {
				int hid = Integer.parseInt(hotelID);
				int kat = Integer.parseInt(kategorija);
				int br_lez = Integer.parseInt(broj_lezaja);
				
				daoAdmin.updateHotelByID(naziv, adresa, kat, br_lez, opis, hid);
				response.sendRedirect(returnPath+"&status=ok");
			}
			
			catch(Exception e){
				response.sendRedirect("error.jsp");
			}
		}
	}

}
