package rs;

import java.io.IOException;
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
		DAO dao = new DAO();
		for(int i=0;i<akcija.length;i++){
			if(akcija[i].equals("profil")){
				ArrayList<Rezervacija> lsrez = dao.getRezervacijaByKorisnickoIme(username);
				loginSesija.setAttribute("lsrez", lsrez);
				
				request.setAttribute("msg", "Uspesna rezervacija");
				request.getRequestDispatcher("profilKorisnika.jsp").forward(request, response);
			}
			
			else if(akcija[i].equals("zanimljivo")){
				String akt = request.getParameter("akt");
				Korisnik kor = (Korisnik)loginSesija.getAttribute("kor");
				
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
		
	}

}
