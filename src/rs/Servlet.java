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
		if(akcija.equals("trazi")){
			String pretraga = request.getParameter("pretraga");
			if(pretraga!=null && pretraga.trim().length()>0){
				if (pretraga.trim().length()>=3) {
					DAO dao = new DAO();
					ArrayList<Hotel> ls = dao.selectHoteli(pretraga);
					request.setAttribute("ls", ls);
					request.getRequestDispatcher("listaHotela.jsp").forward(request, response);
					
				} 
				
				else {
					request.setAttribute("msg", "Naziv hotela ne sme biti kraci od 3 karaktera.");
					request.getRequestDispatcher("index.jsp").forward(request, response);
				}
			}
			
			else {
				request.setAttribute("msg", "Morate uneti naziv hotela");
				request.getRequestDispatcher("index.jsp").forward(request, response);
			}
		}
		
		else if(akcija.equals("jedanHotel")){
			response.sendRedirect("hotelDetalji.jsp");
		}
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
