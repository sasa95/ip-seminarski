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
		
		
		
		
}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String akcija = request.getParameter("akcija");
		DAOSuperAdmin daoSuperAdmin = new DAOSuperAdmin();
		if(akcija.equals("Prijava")){
			String username=request.getParameter("username");
			String password = request.getParameter("password");
			
			if(username!=null && password!=null && username.trim().length()>0 && password.trim().length()>0){
				if(daoSuperAdmin.superLogin(username, password)){
					HttpSession superAdminSesija = request.getSession();
					superAdminSesija.setMaxInactiveInterval(600);
					
					
					superAdminSesija.setAttribute("adminUsername", username);
					request.getRequestDispatcher("indexSuperAdmin.jsp").forward(request, response);	
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
	}

}
