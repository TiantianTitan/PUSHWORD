import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class ServletInit
 */
@WebServlet("/ServletInit")
public class ServletInit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Parkings parkings;
	Thread model;
	Gson gson;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletInit() {
        super();
        
    }

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
    

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setStatus(200);
		response.getWriter().write(gson.toJson(parkings));
	}

	public void destroy() {
		model.interrupt();
	}
	
}
