import java.util.ArrayList;
import java.util.List;


public class Utilisateur {

		String nom;
		String login;
		String mdp;
		List<Emprunt> emprunts;
		
		public Utilisateur(String nom, String login, String mdp)
		{
			this.emprunts = new ArrayList<>();
			this.nom = nom;
			this.login = login;
			this.mdp = mdp;
		}

		public void emprunte(Emprunt e) {
			emprunts.add(e);
		}
		
		public boolean rend(Emprunt e) {
			return emprunts.remove(e);
		}
		
		public String toString() {
			return "nom: " + nom + " login: " + login;
		}	


}
