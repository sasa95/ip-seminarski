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
		DAO dao = new DAO();
		if(akcija.equals("trazi")){
			String pretraga = request.getParameter("pretraga");
			if(pretraga!=null && pretraga.trim().length()>0){
				if (pretraga.trim().length()>=3) {
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
			String id = request.getParameter("id");
			int idh = Integer.parseInt(id);
			
			Hotel h = dao.selectHotelByID(idh);
			request.setAttribute("h", h);
			
			ArrayList<SobaTip_sobe>lsts = dao.brojSoba(idh);
			request.setAttribute("lsts", lsts);
			
			ArrayList<Usluga>lsusluga = dao.selectHoteliUsluge(idh);
			request.setAttribute("lsusluga", lsusluga);
			
			ArrayList<Tretman>lstretman = dao.selectHoteliTretmani(idh);
			request.setAttribute("lstretman", lstretman);
			
			ArrayList<Trzni_centar>lscentar=dao.selectTrzniCentar(idh);
			request.setAttribute("lscentar", lscentar);
			
			ArrayList<Vrsta_aktivnosti> lsaktivnost=dao.selectVrsteAktivnosti(idh);
			request.setAttribute("lsaktivnost", lsaktivnost);
			
			request.getRequestDispatcher("hotelDetalji.jsp").forward(request, response);
									
		}
		
		else if(akcija.equals("detaljiCentra")){
			String id = request.getParameter("hotelID");
			String centarID = request.getParameter("centarID");
			int idh = Integer.parseInt(id);
			int idc = Integer.parseInt(centarID);
			
			Trzni_centar nazivCentra = dao.getCentarNazivByCentarID(idc);
			request.setAttribute("nazivCentra", nazivCentra);
			
			ArrayList<Trzni_centar_prodavnica> lsprodavnica = dao.selectProdavniceByCentarId(idh, idc);
			request.setAttribute("lsprodavnica", lsprodavnica);
			request.getRequestDispatcher("trzniCentarDetalji.jsp").forward(request, response);
		}
		else if(akcija.equals("AktivnostDetalji")){
			String aktivnostID = request.getParameter("aktivnostID");
			int aktID = Integer.parseInt(aktivnostID);
			String id = request.getParameter("hotelID");
			int idh = Integer.parseInt(id);
			
			Vrsta_aktivnosti nazivAktivnosti = dao.getVrstaAktivnostiByID(aktID);
			request.setAttribute("nazivAktivnosti", nazivAktivnosti);
			
			ArrayList<Aktivnost> akt = dao.getAktivnostByID(aktID);
			request.setAttribute("akt", akt);
			
			ArrayList<Hotel_aktivnost>lsakt = dao.getDetaljiAktivnosti(idh, aktID);
			request.setAttribute("lsakt", lsakt);
			
			
			request.getRequestDispatcher("aktivnostiDetalji.jsp").forward(request, response);
			
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
