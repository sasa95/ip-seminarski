package rs;

import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/Servlet_profil")
public class Servlet_profil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public Servlet_profil() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String [] akcija = request.getParameterValues("akcija");
		HttpSession loginSesija = request.getSession();
		String username = (String)loginSesija.getAttribute("username");
		Korisnik kor = (Korisnik)loginSesija.getAttribute("kor");
		
		
		
		
		DAO dao = new DAO();
		for(int i=0;i<akcija.length;i++){
			if(akcija[i].equals("profil")){
				Korisnik korisnik = dao.getKorisnikByUsername(username);
				request.setAttribute("korisnik", korisnik);
				ArrayList<Hotel_Rezervacija_Usluga> lsrez = dao.getRezervacijaByKorisnickoIme(username);
				loginSesija.setAttribute("lsrez", lsrez);
				
				if(kor!=null){
					String lk = kor.getBroj_licne_karte();
					ArrayList<Hotel_aktivnost>lsakt = dao.getDodataAktivnost(lk);
					loginSesija.setAttribute("lsakt", lsakt);
				}
				request.setAttribute("msg", "Uspesna rezervacija");
				request.getRequestDispatcher("profilKorisnika.jsp").forward(request, response);
			}
			
			if(akcija[i].equals("zanimljivo")){
				String akt = request.getParameter("akt");
				
				
				if(kor!=null){
					String broj_licne_karte = kor.getBroj_licne_karte();
					String returnString = (String)loginSesija.getAttribute("returnString");
					int a_id = Integer.parseInt(akt);
					
					dao.insertKorisniciAktivnosti(broj_licne_karte, a_id);
					//request.getRequestDispatcher(path).forward(request, response);
					//response.sendRedirect(path);
					request.getRequestDispatcher(returnString).forward(request, response);
					
				}
				
				else {
					response.sendRedirect("prijava.jsp");
				}
				
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		DAO dao = new DAO();
		String akcija = request.getParameter("akcija"); 
		HttpSession loginSesija = request.getSession();
		String username = (String)loginSesija.getAttribute("username");
		Korisnik korisnik = dao.getKorisnikByUsername(username);
		if(akcija.equals("izmeniKorisnickeDetalje")){
			String broj_licne_karte = request.getParameter("broj_licne_karte");
			String ime = request.getParameter("ime");
			String prezime = request.getParameter("prezime");
			String adresa = request.getParameter("adresa");
			String email = request.getParameter("email");
			String korisnicko_ime = request.getParameter("korisnicko_ime");
			String lozinka1 = request.getParameter("lozinka1");
			String lozinka2 = request.getParameter("lozinka2");

			if (broj_licne_karte != null && broj_licne_karte.trim().length()>0 &&
					ime != null && ime.trim().length()>0 &&
					prezime != null && prezime.trim().length()>0 &&
					adresa != null && adresa.trim().length()>0 &&
					email != null && email.trim().length()>0 &&
					korisnicko_ime != null && korisnicko_ime.trim().length()>0 &&
					lozinka1 != null && lozinka1.trim().length()>0) {
					if(lozinka1.equals(korisnik.getLozinka())){
						if (broj_licne_karte.trim().length()==9) {
							if (ime.trim().length()>=3 && prezime.trim().length()>=3) {
								if (adresa.trim().length()>8) {
									if (lozinka2.equals("") || lozinka2.length()>7) {
										if (broj_licne_karte.matches("[0-9]+"))	{
											if(email.contains("@") && email.trim().length()>5) {
												try {
													String [] splitAt = email.split("@");
													String part1 = splitAt[0];
													String part2 = splitAt[1];
													
													if(part1.trim().length()>2) {
														if(part2.trim().length()>2) {
															if(part2.contains(".")) {
																try {
																	
																	String [] splitDot = part2.split("\\.");
																	String part3 = splitDot[1];
																	
																	if(part3.trim().length()>1) {
																		if(lozinka2!=null && !lozinka2.equals("")){
																			dao.updateKorisnikByUsername(broj_licne_karte, ime, prezime, adresa, lozinka2, email, korisnik.getKorisnicko_ime());
																		}
																		else {
																			dao.updateKorisnikByUsername(broj_licne_karte, ime, prezime, adresa, lozinka1, email, korisnik.getKorisnicko_ime());
																		}
																		
																		response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Uspešna izmena podataka.","UTF-8"));
																	}
																	else {
																		response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Deo email-a nakon tacke mora imati bar 2 karaktera!","UTF-8"));
																	}
																	
																	
																} catch (Exception e1) {
																	response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Deo email-a nakon tacke ne sme ostati prazan!","UTF-8"));
																}
															}
															else {
																response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Deo email-a desno od znaka '@' mora sadrzati tacku!","UTF-8"));
															}
														}
														else {
															response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Deo email-a desno od znaka '@' mora sadrzati bar 3 karaktera!","UTF-8"));
														}
													}
													else {
														response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Deo email-a levo od znaka '@' mora sadrzati bar 3 karaktera!","UTF-8"));
													}
												
												} catch (Exception e1) {
													response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Deo email-a nakon znaka @ ne sme ostati prazan!","UTF-8"));
												}
													

											}
											else {
												response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Email mora sadrzati znak '@' i mora imati bar 6 karaktera!","UTF-8"));
											}
										}
										else {
											response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Broj lične karte mora sadržati samo numeričke vrednosti.","UTF-8"));
										}
									}
									else {
										response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Nova lozinka mora sadržati najmanje 8 karaktera","UTF-8"));
									}
								}
								else {
									response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Adresa ne sme biti kraća od 8 karaktera.","UTF-8"));
								}
							}
							else {
								response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Ime i prezime ne smeju biti kraći od 3 karaktera.","UTF-8"));
								
							}
						}
					
						else {
							response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Broj lične karte mora imati 9 karaktera.","UTF-8"));
						}
					}
					else {
						response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg="+URLEncoder.encode("Pogrešna lozinka.","UTF-8"));
					}
				
				}
				else {
					response.sendRedirect("Servlet_profil?akcija=profil&username="+korisnik.getKorisnicko_ime()+"&msg=Morate popuniti sva polja.");
				}
		}
	}

}
