package rs;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Servlet_sesija")
public class Servlet_sesija extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public Servlet_sesija() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String akcija = request.getParameter("akcija");
		if(akcija.equals("logout")){
			HttpSession loginSesija = request.getSession();
			loginSesija.invalidate();
			response.sendRedirect("index.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String akcija = request.getParameter("akcija");
		
		DAO dao = new DAO();
		
		if(akcija.equals("Prijava")) {
			String username=request.getParameter("username");
			String password = request.getParameter("password");
			String ime = request.getParameter("ime");
			String prezime = request.getParameter("prezime");
			String adresa = request.getParameter("adresa");
			String email = request.getParameter("email");

			if(username!=null && password!=null && username.trim().length()>0 && password.trim().length()>0){
				if(dao.login(username, password)){
					HttpSession loginSesija = request.getSession();
					loginSesija.setAttribute("username", username);
					Korisnik kor = dao.getKorisnikByUsername(username, ime, prezime, adresa, email);
					loginSesija.setAttribute("kor", kor);


					
					String fullString = (String)loginSesija.getAttribute("fullString");
					if(fullString!=null){
						request.getRequestDispatcher(fullString).forward(request, response);
					}
					else {
						loginSesija.setAttribute("msg", "Dobrodošli, "+username);
						request.getRequestDispatcher("index.jsp").forward(request, response);
					}
				}
				
				else {
					request.setAttribute("msg", "Pogrešni parametri za prijavu");
					request.getRequestDispatcher("prijava.jsp").forward(request, response);
				}
			}
			
			else {
				request.setAttribute("msg", "Morate popuniti oba polja");
				request.getRequestDispatcher("prijava.jsp").forward(request, response);
			}
		}
	
	}
	
}
