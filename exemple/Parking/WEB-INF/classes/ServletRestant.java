

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class ServletRestant
 */
@WebServlet("/ServletRestant")
public class ServletRestant extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	Parkings parkings;
	Thread model;
	Gson gson;
	
    public void init() {
    	ServletContext cont = getServletContext();
    	if(cont.getAttribute("parkings") != null) {parkings = (Parkings) cont.getAttribute("parkings");}
    	else {
    		parkings = Exemple1.parkings1();
    		model = new Thread(new ModelThread(parkings));
    		model.start();
    	};
		this.gson = new GsonBuilder().serializeNulls().create();
    }
    
    public ServletRestant() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("id") != null) {
			try {
			int id = Integer.parseInt(request.getParameter("id"));
			System.out.println("Appel places restantes sur id: " + id);
			Optional<Parking> opark = parkings.trouveId(id);
			if(opark.isPresent()) {
				int restant = opark.get().max - opark.get().occupe;
				System.out.println("Places restantes  à " + id + " : " + String.valueOf(restant));
				response.getWriter().write(String.valueOf(restant));
				}
			} catch (Exception e) {
			}		
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public void destroy() {
		model.interrupt();
	}
	

}
