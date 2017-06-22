package rs;

import java.io.IOException;
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
		if(akcija.equals("logout")){
			HttpSession adminSesija = request.getSession();
			adminSesija.invalidate();
			response.sendRedirect("index.jsp");
		}
		
		else if(akcija.equals("hotelDetalji")){
			String hotelID = request.getParameter("hotelID");
			try {
				int hid = Integer.parseInt(hotelID);
				Hotel hotel = daoAdmin.getHotelByID(hid);
				request.setAttribute("hotel", hotel);
				request.getRequestDispatcher("adminHotelDetalji.jsp").forward(request, response);
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
