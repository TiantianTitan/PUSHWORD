import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


public class Rayon {

	Map<Integer, Livre> rayon;
	
	public Rayon() {
		rayon = new HashMap<>();
	}
	
	public List<Livre> trouveTitre(String titre){
		List<Livre> resultat = new ArrayList<>();
		for (Livre l : rayon.values()) {
			if(titre.equals(l.titre)){resultat.add(l);}
		};
		return resultat;
	}
	
	public List<Livre> trouveAuteur(String auteur){
		List<Livre> resultat = new ArrayList<>();
		for (Livre l : rayon.values()) {
			if(l.auteur.equals(auteur)){resultat.add(l);}
		};
		return resultat;
	}
	
	public Optional<Livre> trouveId(Integer id){
		Livre res = rayon.get(id);
		return Optional.ofNullable(res);
	}
	
	
	public void ajouteLivre(Livre l) {
		rayon.put(l.id, l);
	}
	
}


