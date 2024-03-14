

public class Livre {

	String titre;
	String auteur;
	int publication;
	int id;
	int disponible;
	
	public Livre(String titre, String auteur, int publication, int id)
	{
		this.titre = titre;
		this.auteur = auteur;
		this.publication = publication;
		this.id = id;
		this.disponible = 0;
	}

	public void ajoute() {
		this.disponible ++;
	}
	
	public void emprunte() {
		this.disponible --;
	}

	public String toString() {
		return titre + " de " + auteur + " publié en " + publication;
	}	

}


