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


@WebServlet("/FileUpload")
public class FileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public FileUpload() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession adminSesija = request.getSession();
		int hot_id = (Integer)adminSesija.getAttribute("hot_id");
		String akcija = request.getParameter("akcija");
		try {
			
			 ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
			 List<FileItem>multifiles = sf.parseRequest(request);
			 
			 for(FileItem item:multifiles){
				 if(akcija.equals("addHotelPic")){
					 item.write(new File("C:\\Users\\saleg\\workspace\\0-ip-seminarski\\WebContent\\img\\hoteli\\"+hot_id+".jpg"));
					 Thread.sleep(6000);
					 response.sendRedirect("Servlet_admin?akcija=hotelDetalji&hotelID="+hot_id);
				 }
				 
			 }
			 
		    } 
		 
		 	catch (Exception e) {
		        
		    }
		
		
	}

}
