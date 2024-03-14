import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class Inscrits {

		Map<String, Utilisateur> base;
		
		public Inscrits() {
			base = new HashMap<>();
		}
		
		public Optional<Utilisateur> trouveUtilisateur(String login){
			Utilisateur res = null;
			for (Utilisateur u : base.values()) {
				if(login.equals(u.login)){res = u; break;}
			};
			return Optional.ofNullable(res);
		}

		public void ajouteUtilisateur(Utilisateur u) {
			base.put(u.login, u);
		}
	
}
