package rs;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UserPicUpload
 */
@WebServlet("/UserPicUpload")
public class UserPicUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPicUpload() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession loginSesija = request.getSession();
		Korisnik kor =(Korisnik)loginSesija.getAttribute("kor");
		String username = kor.getKorisnicko_ime();
		try {
			
			 ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
			 List<FileItem>multifiles = sf.parseRequest(request);
			 
			 for(FileItem item:multifiles){
				 item.write(new File("C:\\Users\\saleg\\workspace\\0-ip-seminarski\\WebContent\\img\\korisnici\\"+username+".jpg"));
				 Thread.sleep(6000);
				 response.sendRedirect("Servlet_profil?akcija=profil&username="+username);
			 }
			 
		    } 
		 
		 	catch (Exception e) {
		        response.sendRedirect("error.jsp");
		    }
	}

}
