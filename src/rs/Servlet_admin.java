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
		String adminUsername = (String)adminSesija.getAttribute("adminUsername");
		
		if(adminUsername!=null){
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
			
			else if(akcija.equals("zaposleniTabela")){
				Hotel hotel = daoAdmin.getHotelByID(hot_id);
				ArrayList<Rukovodilac>lsruk = daoAdmin.getRukovodiociByHotelID(hot_id);
				ArrayList<Posao>lsp = daoAdmin.getPoslovi();
				ArrayList<Zaposleni_posao>lszap = daoAdmin.getZaposleniByHotelID(hot_id);
				for(Zaposleni_posao z:lszap){
					z.setNaziv_posla(daoAdmin.getPosaoByID(z.getPosaoID()));
					if(z.getRukovodilacID() !=0){
						z.setImeRuk(daoAdmin.getRukovodilacByID(z.getRukovodilacID()).getIme());
						z.setPrezimeRuk(daoAdmin.getRukovodilacByID(z.getRukovodilacID()).getPrezime());
					}
				}
				
				request.setAttribute("lsruk", lsruk);
				request.setAttribute("lsp", lsp);
				request.setAttribute("lszap", lszap);
				request.setAttribute("hotel", hotel);
				request.getRequestDispatcher("adminZaposleni.jsp").forward(request, response);
			}
			
			else if(akcija.equals("obrisiZaposlenog")){
				String zaposleniID = request.getParameter("zaposleniID");
				try {
					int z_id = Integer.parseInt(zaposleniID);
					daoAdmin.deleteZaposleniByID(z_id);
					response.sendRedirect("Servlet_admin?akcija=zaposleniTabela&hotelID="+hot_id+"&status=okD");
				}
				
				catch(Exception e){
					response.sendRedirect("error.jsp");
				}
			}
			
			else if(akcija.equals("izmeniZaposlenog")){
				String zaposleniID = request.getParameter("zaposleniID");
				try {
					int z_id = Integer.parseInt(zaposleniID);
					Zaposleni zaposleni = daoAdmin.getZaposleniByID(z_id);
					Rukovodilac rukovodilac = daoAdmin.getRukovodilacByZaposleniID(z_id);
					adminSesija.setAttribute("rukovodilac", rukovodilac);
					adminSesija.setAttribute("zaposleni", zaposleni);
					response.sendRedirect("Servlet_admin?akcija=zaposleniTabela&hotelID="+hot_id+"&zaposleniID="+z_id);
				}
				
				catch(Exception e){
					response.sendRedirect("error.jsp");
				}
			}
			
			else if(akcija.equals("rukovodiociTabela")){
				Hotel hotel = daoAdmin.getHotelByID(hot_id);
				request.setAttribute("hotel", hotel);
				request.getRequestDispatcher("adminRezervacije.jsp").forward(request, response);
			}
			
		}
		
		else {
			response.sendRedirect("prijava.jsp");
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String akcija = request.getParameter("akcija");
		DAOAdmin daoAdmin = new DAOAdmin();
		HttpSession adminSesija = request.getSession();
		int hot_id = (Integer)adminSesija.getAttribute("hot_id");
		if(akcija.equals("izmeniHotel")){
			String hotelID = request.getParameter("hotelID");
			String naziv = request.getParameter("naziv");
			String adresa = request.getParameter("adresa");
			String kategorija = request.getParameter("kategorija");
			String broj_lezaja = request.getParameter("broj_lezaja");
			String opis = request.getParameter("opis");
			String returnPath = request.getParameter("returnPath");
			
			if(hotelID!=null && hotelID.trim().length()>0 && naziv!=null && naziv.trim().length()>0 &&
				adresa!=null && adresa.trim().length()>0 && kategorija!=null && kategorija.trim().length()>0 &&
				broj_lezaja!=null && broj_lezaja.trim().length()>0){
				
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
			
			else {
				response.sendRedirect(returnPath+"&status=empty");
			}
		
		}
		
		else if(akcija.equals("unosZaposlenog")){
			String ime = request.getParameter("ime");
			String prezime = request.getParameter("prezime");
			String plata = request.getParameter("plata");
			String posaoID = request.getParameter("posaoID");
			String rukovodilacID = request.getParameter("rukovodilacID");
			
			if(ime!=null && ime.trim().length()>0 && prezime!=null && prezime.trim().length()>0 && 
				plata!=null && plata.trim().length()>0 && posaoID!=null && posaoID.trim().length()>0){
				
				try {
					int plat = Integer.parseInt(plata);
					int posID = Integer.parseInt(posaoID);
					if(!rukovodilacID.equals("")){
						int rukID = Integer.parseInt(rukovodilacID);
						daoAdmin.insertZaposleni(ime, prezime, plat, hot_id, posID, rukID);
					}
					
					else {
						daoAdmin.insertZaposleniWithoutRuk(ime, prezime, plat, hot_id, posID);
					}
					
					
					response.sendRedirect("Servlet_admin?akcija=zaposleniTabela&status=okI&hotelID="+hot_id);
				}
				
				catch(Exception e){
					response.sendRedirect("Servlet_admin?akcija=zaposleniTabela&msg=Pogresan format unosa&hotelID="+hot_id);
				}
			}
			
			else {
				response.sendRedirect("Servlet_admin?akcija=zaposleniTabela&msg=Morate popuniti sva polja&hotelID="+hot_id);
			}
		}
		
		else if(akcija.equals("izmenaZaposlenog")){
			String zaposleniID = request.getParameter("zaposleniID");
			String ime = request.getParameter("ime");
			String prezime = request.getParameter("prezime");
			String plata = request.getParameter("plata");
			String posaoID = request.getParameter("posaoID");
			String rukovodilacID = request.getParameter("rukovodilacID");
			
			if(ime!=null && ime.trim().length()>0 && prezime!=null && prezime.trim().length()>0 && 
				plata!=null && plata.trim().length()>0 && posaoID!=null && posaoID.trim().length()>0){
				try {
					int zap_id = Integer.parseInt(zaposleniID);
					float plat = Float.parseFloat(plata);
					int posID = Integer.parseInt(posaoID);
					
					if(!rukovodilacID.equals("")){
						int rukID = Integer.parseInt(rukovodilacID);
						daoAdmin.updateZaposleniByID(ime, prezime, plat, posID, rukID, zap_id);
					}
					
					else {
						daoAdmin.updateZaposleniByIDwithoutRuk(ime, prezime, plat, posID, zap_id);
					}
					
					adminSesija.removeAttribute("rukovodilac");
					adminSesija.removeAttribute("zaposleni");
					response.sendRedirect("Servlet_admin?akcija=zaposleniTabela&status=okU&hotelID="+hot_id);
				}
				
				catch(Exception e){
					response.sendRedirect("Servlet_admin?akcija=zaposleniTabela&msg=Pogresan format unosa&hotelID="+hot_id);
				}
			}
			
			else {
				response.sendRedirect("Servlet_admin?akcija=zaposleniTabela&msg=Morate popuniti obavezna polja&hotelID="+hot_id);
			}
		}
	}

}
