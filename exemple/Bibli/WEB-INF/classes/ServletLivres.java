

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


@WebServlet("/ServletLivres")
public class ServletLivres extends HttpServlet {
	
	Gson gson;
	Rayon rayon;
	
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletLivres() {
        super();

    }

    public void init() {
    	ServletContext cont = getServletContext();
    	if(cont.getAttribute("rayon") != null) {rayon = (Rayon) cont.getAttribute("rayon");}
    	else {rayon = Exemple1.exemple1Rayon(); cont.setAttribute("rayon", rayon);};
		this.gson = new GsonBuilder().serializeNulls().create();
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String titre = request.getParameter("titre");
		String auteur = request.getParameter("auteur");
		String id = request.getParameter("id");
			if(titre != null) {
			List<Livre> res = rayon.trouveTitre(titre);
			response.setContentType("application/json");
			System.out.println("Recherche par titre: "+ titre);
			System.out.println("Résultat: " + res.toString());
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(gson.toJson(res));
		}
		else if(auteur != null) {
			List<Livre> res = rayon.trouveAuteur(auteur);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(gson.toJson(res));
		}
		else if(id != null) {
			if(rayon.trouveId(Integer.parseInt(id)).isPresent()) {
			Livre res = rayon.trouveId(Integer.parseInt(id)).get();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(gson.toJson(res));
			}
		}
		else {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setStatus(404);
			response.getWriter().write(gson.toJson(new ArrayList<>()));
		}
	}


}
