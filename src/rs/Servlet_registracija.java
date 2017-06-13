package rs;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Servlet_registracija")
public class Servlet_registracija extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Servlet_registracija() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
														request.setAttribute("msg", "Uspešna registracija. Sada se možete prijaviti.");
														request.getRequestDispatcher("prijava.jsp").forward(request, response);
													}
													else {
														request.setAttribute("msg", "Broj lične karte mora sadržati samo numeričke vrednosti.");
														request.getRequestDispatcher("registracija.jsp").forward(request, response);
													}
												}
												else {
													request.setAttribute("msg", "Lozinka mora sadržati najmanje jedno malo i veliko slovo, broj i bar jedan od navedenih alfanumeričkih karaktera - @#%$^");
													request.getRequestDispatcher("registracija.jsp").forward(request, response);
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

