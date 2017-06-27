package rs;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/administrator")
public class Servlet_super_admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Servlet_super_admin() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession superAdminSesija = request.getSession();
		DAOSuperAdmin daoSuperAdmin = new DAOSuperAdmin();
		String akcija = request.getParameter("akcija");
		if(akcija==null){
			response.sendRedirect("prijavaSuperAdmin.jsp");
		}
		
		else if(akcija.equals("logout")){
			superAdminSesija.invalidate();
			response.sendRedirect("index.jsp");
		}
		
		else if(akcija.equals("tabelaHoteli")){
			ArrayList<Hotel>lshoteli = daoSuperAdmin.getHoteli();
			request.setAttribute("lshoteli", lshoteli);
			request.getRequestDispatcher("superAdminHoteli.jsp").forward(request, response);
		}
		
		else if(akcija.equals("obrisiHotel")){
			String hotelID = request.getParameter("hotelID");
			try {
				int hot_id = Integer.parseInt(hotelID);
				daoSuperAdmin.deleteHotelByID(hot_id);
				response.sendRedirect("administrator?akcija=tabelaHoteli&status=okD");
			}
			
			catch(Exception e){
				response.sendRedirect("error.jsp");
			}
		}
		
		else if(akcija.equals("izmeniHotel")){
			String hotelID = request.getParameter("hotelID");
			try {
				int hot_id = Integer.parseInt(hotelID);
				Hotel hotel = daoSuperAdmin.getHotelByID(hot_id);
				superAdminSesija.setAttribute("hotel", hotel);
				response.sendRedirect("administrator?akcija=tabelaHoteli");
			}
			
			catch(Exception e){
				response.sendRedirect("error.jsp");
			}
		}
		
		else if(akcija.equals("tabelaKorisnici")){
			ArrayList<Korisnik>lskor = daoSuperAdmin.getKorisnici();
			ArrayList<Hotel>lshotid = daoSuperAdmin.getHotelID();
			request.setAttribute("lshotid", lshotid);
			request.setAttribute("lskor", lskor);
			request.getRequestDispatcher("superAdminKorisnici.jsp").forward(request, response);
		}
		
		else if(akcija.equals("obrisiKorisnika")){
			String korisnicko_ime = request.getParameter("user");
			daoSuperAdmin.deleteKorisnikByUsername(korisnicko_ime);
			response.sendRedirect("administrator?akcija=tabelaKorisnici&status=okD");
		}
		
		else if(akcija.equals("izmeniKorisnika")){
			String korisnicko_ime = request.getParameter("user");
			Korisnik korisnik = daoSuperAdmin.getKorisnikByUsername(korisnicko_ime);
			superAdminSesija.setAttribute("korisnik", korisnik);
			response.sendRedirect("administrator?akcija=tabelaKorisnici");
		}
		
		else if(akcija.equals("tabelaRezervacije")){
			ArrayList<Rezervacija>lsrez = daoSuperAdmin.getRezervacije();
			request.setAttribute("lsrez", lsrez);
			request.getRequestDispatcher("superAdminRezervacije.jsp").forward(request, response);
		}
}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession superAdminSesija = request.getSession();
		String akcija = request.getParameter("akcija");
		DAOSuperAdmin daoSuperAdmin = new DAOSuperAdmin();
		if(akcija.equals("Prijava")){
			String username=request.getParameter("username");
			String password = request.getParameter("password");
			
			if(username!=null && password!=null && username.trim().length()>0 && password.trim().length()>0){
				if(daoSuperAdmin.superLogin(username, password)){
					superAdminSesija.setMaxInactiveInterval(600);
					
					
					superAdminSesija.setAttribute("adminUsername", username);
					request.getRequestDispatcher("indexSuperAdmin.jsp").forward(request, response);	
				}
				
				else {
					request.setAttribute("msg", "Pogrešni parametri za logovanje");
					request.getRequestDispatcher("prijavaSuperAdmin.jsp").forward(request, response);
				}
			}
			
		}
		
		else if(akcija.equals("unosHotela")){
			String naziv = request.getParameter("naziv");
			String adresa = request.getParameter("adresa");
			String kategorija = request.getParameter("kategorija");
			String broj_lezaja = request.getParameter("broj_lezaja");
			String opis = request.getParameter("opis");
			
			if(naziv!=null && naziv.trim().length()>0 &&
				adresa!=null && adresa.trim().length()>0 && kategorija!=null && kategorija.trim().length()>0 &&
				broj_lezaja!=null && broj_lezaja.trim().length()>0){
				
				try {
					int kat = Integer.parseInt(kategorija);
					int br_lez = Integer.parseInt(broj_lezaja);
					
					daoSuperAdmin.insertHotel(naziv, adresa, kat, br_lez, opis);
					response.sendRedirect("administrator?akcija=tabelaHoteli&status=okI");
				}
				
				catch(Exception e){
					response.sendRedirect("administrator?akcija=tabelaHoteli&status=format");
				}
			}
			
			else {
				response.sendRedirect("administrator?akcija=tabelaHoteli&status=empty");
			}
		}
		
		else if(akcija.equals("izmenaHotela")){
			String naziv = request.getParameter("naziv");
			String adresa = request.getParameter("adresa");
			String kategorija = request.getParameter("kategorija");
			String broj_lezaja = request.getParameter("broj_lezaja");
			String opis = request.getParameter("opis");
			String hotelID = request.getParameter("hotelID");
				
			
			if(naziv!=null && naziv.trim().length()>0 &&
				adresa!=null && adresa.trim().length()>0 && kategorija!=null && kategorija.trim().length()>0 &&
				broj_lezaja!=null && broj_lezaja.trim().length()>0){
				
				try {
					int kat = Integer.parseInt(kategorija);
					int br_lez = Integer.parseInt(broj_lezaja);
					int hot_id = Integer.parseInt(hotelID);
					
					daoSuperAdmin.updateHotelByID(naziv, adresa, kat, br_lez, opis, hot_id);
					superAdminSesija.removeAttribute("hotel");
					response.sendRedirect("administrator?akcija=tabelaHoteli&status=okU");
				}
				
				catch(Exception e){
					response.sendRedirect("administrator?akcija=tabelaHoteli&status=format");
				}
			}
			
			else {
				response.sendRedirect("administrator?akcija=tabelaHoteli&status=empty");
			}
		}
		
		else if(akcija.equals("unosKorisnika")){
			String broj_licne_karte = request.getParameter("broj_licne_karte");
			String ime = request.getParameter("ime");
			String prezime = request.getParameter("prezime");
			String adresa = request.getParameter("adresa");
			String email = request.getParameter("email");
			String korisnicko_ime = request.getParameter("korisnicko_ime");
			String lozinka = request.getParameter("lozinka");
			String hotelID = request.getParameter("hotelID");
			
			if (broj_licne_karte != null && broj_licne_karte.trim().length()>0 &&
				ime != null && ime.trim().length()>0 &&
				prezime != null && prezime.trim().length()>0 &&
				adresa != null && adresa.trim().length()>0 &&
				email != null && email.trim().length()>0 &&
				korisnicko_ime != null && korisnicko_ime.trim().length()>0 &&
				lozinka!= null && lozinka.trim().length()>0
				&& hotelID!=null && hotelID.trim().length()>0){
				
				daoSuperAdmin.insertKorisnik(broj_licne_karte, ime, prezime, adresa, email, korisnicko_ime, lozinka,hotelID);
				response.sendRedirect("administrator?akcija=tabelaKorisnici&status=okI");
				
			}
			
			else {
				response.sendRedirect("administrator?akcija=tabelaKorisnici&status=empty");
			}
		}
		
		else if(akcija.equals("izmenaKorisnika")){
			String broj_licne_karte = request.getParameter("broj_licne_karte");
			String ime = request.getParameter("ime");
			String prezime = request.getParameter("prezime");
			String adresa = request.getParameter("adresa");
			String email = request.getParameter("email");
			String korisnicko_ime = request.getParameter("korisnicko_ime");
			String lozinka = request.getParameter("lozinka");
			String hotelID = request.getParameter("hotelID");
			
			if (broj_licne_karte != null && broj_licne_karte.trim().length()>0 &&
				ime != null && ime.trim().length()>0 &&
				prezime != null && prezime.trim().length()>0 &&
				adresa != null && adresa.trim().length()>0 &&
				email != null && email.trim().length()>0 &&
				korisnicko_ime != null && korisnicko_ime.trim().length()>0 &&
				lozinka!= null && lozinka.trim().length()>0){
				
				try {
					int hot_id = Integer.parseInt(hotelID);
					daoSuperAdmin.updateKorisnikByUsername(broj_licne_karte, ime, prezime, adresa, email, korisnicko_ime, lozinka,hot_id);
					superAdminSesija.removeAttribute("korisnik");
					response.sendRedirect("administrator?akcija=tabelaKorisnici&status=okU");
				}
				
				catch(Exception e){
					response.sendRedirect("administrator?akcija=tabelaKorisnici&status=format");
				}
				
				
			}
			
			else {
				response.sendRedirect("administrator?akcija=tabelaKorisnici&status=empty");
			}
		}
	}

}
