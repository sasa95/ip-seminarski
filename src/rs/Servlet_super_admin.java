package rs;

import java.io.IOException;
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
		DAOSuperAdmin daoSuperAdmin = new DAOSuperAdmin();
		String akcija = request.getParameter("akcija");
		if(akcija==null){
			response.sendRedirect("prijavaSuperAdmin.jsp");
		}
		
		else if(akcija.equals("logout")){
			HttpSession superAdminSesija = request.getSession();
			superAdminSesija.invalidate();
			response.sendRedirect("index.jsp");
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
	}

}
