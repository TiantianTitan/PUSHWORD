public class Exemple1 {

public static Rayon exemple1Rayon() {
	Rayon rayon = new Rayon();
	
	Livre mondehier = new Livre("Le Monde d'Hier", "Stefan Zweig", 1953, 1);
	mondehier.ajoute();	mondehier.ajoute();
	rayon.ajouteLivre(mondehier);
	
	Livre pons = new Livre("Le Cousin Pons", "Honoré de Balzac", 1847, 2);
	pons.ajoute();	pons.ajoute(); pons.ajoute();
	rayon.ajouteLivre(pons);
	
	Livre bette = new Livre("La Cousine Bette", "Honoré de Balzac", 1846, 3);
	bette.ajoute();	
	rayon.ajouteLivre(bette);

	Livre ferme = new Livre("La Ferme Africaine", "Karen Blixen", 1937, 4);
	rayon.ajouteLivre(ferme);
	
	return rayon;
}
	
public static Inscrits exemple1Inscrits() {
	Inscrits base = new Inscrits();
	
	base.ajouteUtilisateur(new Utilisateur("Nicolas Sarkozy", "nico", "carla"));
	base.ajouteUtilisateur(new Utilisateur("François Hollande", "franky", "julie"));
	base.ajouteUtilisateur(new Utilisateur("Valérie Giscard d'Estaing", "vge", "diana"));
	base.ajouteUtilisateur(new Utilisateur("Patrick Balkany", "balka", "isabelle"));	
	return base;
}

public static BaseEmprunts exemple1Base() {
	return new BaseEmprunts();
}


}
