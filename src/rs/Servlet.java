package rs;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String akcija = request.getParameter("akcija");
		DAO dao = new DAO();
		if(akcija.equals("Traži")){
			String pretraga = request.getParameter("pretraga");
			String [] kategorija = request.getParameterValues("kategorija");
			String adresa = request.getParameter("adresa");
			String naziv_vrste_aktivnosti = request.getParameter("naziv_vrste_aktivnosti");
			String vrsta_usluge = request.getParameter("vrsta_usluge");
			
			if(naziv_vrste_aktivnosti==""){
				naziv_vrste_aktivnosti=null;
			}
			if(vrsta_usluge==""){
				vrsta_usluge=null;
			}
			ArrayList<Hotel>hotel= new ArrayList<Hotel>();
			
			if(kategorija!=null && kategorija.length>0){
				for(int i=kategorija.length-1;i>=0; i--){
					hotel.addAll(dao.mainSearch(pretraga, kategorija[i],adresa,naziv_vrste_aktivnosti,vrsta_usluge));
				}
				request.setAttribute("hotel", hotel);
				request.getRequestDispatcher("listaHotela.jsp").forward(request, response);
			}
			
			else if(kategorija==null){
				request.setAttribute("msg", "Morate odabrati bar jednu kategoriju hotela.");
				request.getRequestDispatcher("index.jsp").forward(request, response);
				
			}
		}
		
		else if(akcija.equals("jedanHotel")){
			String id = request.getParameter("id");
			
			try {
				int idh = Integer.parseInt(id);
				
				Hotel h = dao.selectHotelByID(idh);
				request.setAttribute("h", h);
				
				ArrayList<SobaTip_sobe>lsts = dao.brojSoba(idh);
				request.setAttribute("lsts", lsts);
				
				ArrayList<Usluga>lsusluga = dao.selectHoteliUsluge(idh);
				request.setAttribute("lsusluga", lsusluga);
				
				ArrayList<Tretman>lstretman = dao.selectHoteliTretmani(idh);
				request.setAttribute("lstretman", lstretman);
				
				ArrayList<Trzni_centar>lscentar=dao.selectTrzniCentar(idh);
				request.setAttribute("lscentar", lscentar);
				
				ArrayList<Vrsta_aktivnosti> lsaktivnost=dao.selectVrsteAktivnosti(idh);
				request.setAttribute("lsaktivnost", lsaktivnost);
				
				request.getRequestDispatcher("hotelDetalji.jsp").forward(request, response);
			}
			
			catch(Exception e){
				response.sendRedirect("error.jsp");
			}
			
									
		}
		
		else if(akcija.equals("detaljiCentra")){
			String id = request.getParameter("hotelID");
			String centarID = request.getParameter("centarID");
			
			try {
				int idh = Integer.parseInt(id);
				int idc = Integer.parseInt(centarID);
				
				Trzni_centar nazivCentra = dao.getCentarNazivByCentarID(idc);
				request.setAttribute("nazivCentra", nazivCentra);
				
				ArrayList<Trzni_centar_prodavnica> lsprodavnica = dao.selectProdavniceByCentarId(idh, idc);
				request.setAttribute("lsprodavnica", lsprodavnica);
				request.getRequestDispatcher("trzniCentarDetalji.jsp").forward(request, response);
			}
			
			catch(Exception e){
				response.sendRedirect("error.jsp");
			}
			
		}
		else if(akcija.equals("AktivnostDetalji")){
			String aktivnostID = request.getParameter("aktivnostID");
			String id = request.getParameter("hotelID");
			
			
			try {
				int aktID = Integer.parseInt(aktivnostID);
				int idh = Integer.parseInt(id);
				
				Vrsta_aktivnosti nazivAktivnosti = dao.getVrstaAktivnostiByID(aktID);
				request.setAttribute("nazivAktivnosti", nazivAktivnosti);
				
				ArrayList<Aktivnost> akt = dao.getAktivnostByID(aktID,idh);
				request.setAttribute("akt", akt);
				
				ArrayList<Hotel_aktivnost>lsakt = dao.getDetaljiAktivnosti(idh, aktID);
				request.setAttribute("lsakt", lsakt);
				
				
				request.getRequestDispatcher("aktivnostiDetalji.jsp").forward(request, response);
			}
			
			catch(Exception e){
				response.sendRedirect("error.jsp");
			}

		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String broj_licne_karte = request.getParameter("broj_licne_karte");
		String ime = request.getParameter("ime");
		String prezime = request.getParameter("prezime");
		String adresa = request.getParameter("adresa");
		String korisnicko_ime = request.getParameter("korisnicko_ime");
		String lozinka1 = request.getParameter("lozinka1");
		String lozinka2 = request.getParameter("lozinka2");

		if (broj_licne_karte != null && broj_licne_karte.trim().length()>0 &&
				ime != null && ime.trim().length()>0 &&
				prezime != null && prezime.trim().length()>0 &&
				adresa != null && adresa.trim().length()>0 &&
				korisnicko_ime != null && korisnicko_ime.trim().length()>0 &&
				lozinka1 != null && lozinka1.trim().length()>0 &&
				lozinka2 != null && lozinka2.trim().length()>0) {
					if (broj_licne_karte.trim().length()==9) {
						if (ime.trim().length()>=3 && prezime.trim().length()>=3) {
							if (adresa.trim().length()>8) {
								if (korisnicko_ime.trim().length()>=5) {
									if (lozinka1.trim().length()>7) {
										if (lozinka1.equals(lozinka2)){
											if (!korisnicko_ime.contains(" ")) {
												if ((lozinka1.matches("^.*(?=.{8,})(?=..*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*$"))) {
													if (broj_licne_karte.matches("[0-9]+"))	{
														DAO dao = new DAO();
														dao.insertKorisnik(broj_licne_karte, ime, prezime, adresa, korisnicko_ime, lozinka1);
														request.setAttribute("msg", "Uspešna registracija. Sada se možete ulogovati.");
														request.getRequestDispatcher("index.jsp").forward(request, response);
													}
													else {
														request.setAttribute("msg", "Broj lične karte mora sadržati samo numeričke vrednosti.");
														request.getRequestDispatcher("registracija.jsp").forward(request, response);
													}
												}
												else {
													request.setAttribute("msg", "Lozinka mora sadržati najmanje jedno malo i veliko slovo, broj i bar jedan od navedenih alfanumeričkih karaktera - @#%$^");
													request.getRequestDispatcher("index.jsp").forward(request, response);
												}
											}
											else {
												request.setAttribute("msg", "Korisničko ime ne sme imati razmak.");
												request.getRequestDispatcher("registracija.jsp").forward(request, response);
											}
										}
										else {
											request.setAttribute("msg", "Lozinke moraju biti identične.");
											request.getRequestDispatcher("registracija.jsp").forward(request, response);
										}
									}
									else {
										request.setAttribute("msg", "Lozinke ne sme biti kraća od 8 karaktera.");
										request.getRequestDispatcher("registracija.jsp").forward(request, response);
									}
									
								}
								else {
									request.setAttribute("msg", "Korisničko ime mora imati najmanje 5 karaktera");
									request.getRequestDispatcher("registracija.jsp").forward(request, response);
								}
							}
							else {
								request.setAttribute("msg", "Adresa ne sme biti kraća od 8 karaktera.");
								request.getRequestDispatcher("registracija.jsp").forward(request, response);
							}
						}
						else {
							request.setAttribute("msg", "Ime i prezime ne smeju biti kraći od 3 karaktera.");
							request.getRequestDispatcher("registracija.jsp").forward(request, response);
						}
					}
					else {
						request.setAttribute("msg", "Broj lične karte mora imati 9 karaktera.");
						request.getRequestDispatcher("registracija.jsp").forward(request, response);
					}
			
			}
			else {
				request.setAttribute("msg", "Morate popuniti sva polja.");
				request.getRequestDispatcher("registracija.jsp").forward(request, response);
			}
		}
	}