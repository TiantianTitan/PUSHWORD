

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
 * Servlet implementation class Utilisateurs
 */

@WebServlet("/Utilisateurs")
public class ServletUtilisateurs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	Gson gson;
	Inscrits base;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletUtilisateurs() {
        super();
    }

    public void init() {
    	ServletContext cont = getServletContext();
    	if(cont.getAttribute("baseU") != null) {base = (Inscrits) cont.getAttribute("baseU");}
    	else {base = Exemple1.exemple1Inscrits(); cont.setAttribute("baseU", base);};
		this.gson = new GsonBuilder().serializeNulls().create();
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("login");
		if(login != null) {
		Optional<Utilisateur> ores = base.trouveUtilisateur(login);
		response.setContentType("application/json");
		System.out.println("Recherche par login: "+ login);
		if(ores.isPresent()) {
			System.out.println("Résultat: " + ores.get().toString());
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(gson.toJson(ores.get()));
		} else {response.getWriter().write(gson.toJson(null));}}
		else {System.out.println("Pas de login");}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("login");
		String mdp = request.getParameter("mdp");
		if(login != null && mdp != null) {
		Optional<Utilisateur> ores = base.trouveUtilisateur(login);
		response.setContentType("application/json");
		System.out.println("Authentification par login: "+ login + " mdp: " + mdp);
		if(ores.isPresent()) {
			if(mdp.equals(ores.get().mdp)) 
				{response.getWriter().write(gson.toJson(new AuthReponse("ok", login)));
				System.out.println("Réussie.");
				} else {
				response.getWriter().write(gson.toJson(new AuthReponse("mdp", login)));
				System.out.println("Mauvais Mdp.");}
			} else {
			response.getWriter().write(gson.toJson(new AuthReponse("login", login)));
			System.out.println("Mauvais login");}
		} else {System.out.println("Pas de login");}		
	}
}
