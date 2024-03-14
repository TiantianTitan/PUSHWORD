import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


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

@WebServlet("/ServletEmprunts")
public class ServletEmprunts extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	Gson gson;
	BaseEmprunts baseE;
	Inscrits baseU;
	Rayon rayon;
	int counter;
	
	
    public void init() {
    	ServletContext cont = getServletContext();
    	if(cont.getAttribute("baseU") != null) {baseU = (Inscrits) cont.getAttribute("baseU");}
    	else {baseU = Exemple1.exemple1Inscrits(); cont.setAttribute("baseU", baseU);};
    	if(cont.getAttribute("rayon") != null) {rayon = (Rayon) cont.getAttribute("rayon");}
    	else {rayon = Exemple1.exemple1Rayon(); cont.setAttribute("rayon", rayon);};
    	if(cont.getAttribute("baseE") != null) {baseE = (BaseEmprunts) cont.getAttribute("rayon");}
    	else {baseE = Exemple1.exemple1Base(); cont.setAttribute("baseE", baseE);};
		this.gson = new GsonBuilder().serializeNulls().create();		
		counter = 0;
    }
    
	
	
    public ServletEmprunts() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = null;
		if(request.getParameter("id") != null) {
			id = Integer.parseInt(request.getParameter("id"));
			Optional<Emprunt> ores = baseE.trouveEmprunt(id);
			response.setContentType("application/json");
			System.out.println("Recherche par id: "+ id.toString());
			System.out.println("Résultat: " + ores.toString());
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(gson.toJson(ores));
			if(ores.isEmpty()) {response.setStatus(404);}
			}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sid = request.getParameter("id");
		String login = request.getParameter("login");
		if(sid == null || login == null) {
			response.setStatus(404);
		} else {
			if(rayon.trouveId(Integer.parseInt(sid)).isPresent() && baseU.trouveUtilisateur(login).isPresent()) {
			Livre livre = rayon.trouveId(Integer.parseInt(sid)).get();
			Utilisateur util = baseU.trouveUtilisateur(login).get();
			counter++;
			Emprunt emp = new Emprunt(counter, util.login, livre);
			baseE.ajouteEmprunt(emp);
			util.emprunte(emp);
			livre.emprunte();
			} else {
			response.setStatus(404);
			}
	}
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		if(id == null) {
			response.setStatus(404);
			System.out.println("Mauvais Id");
		} else {
			if(baseE.trouveEmprunt(Integer.parseInt(id)).isPresent()) {
			Emprunt emp = baseE.trouveEmprunt(Integer.parseInt(id)).get();
			baseE.retireEmprunt(emp);
			emp.substrat.ajoute();
			if(baseU.trouveUtilisateur(emp.emprunteur).isPresent()) {
				Utilisateur util = baseU.trouveUtilisateur(emp.emprunteur).get();
				util.rend(emp);
			}
			} else {
			response.setStatus(404);
			System.out.println("Id plus dans la base.");
			}
		}
	}	
	
}
		
	
	

