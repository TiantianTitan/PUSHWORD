
public class Parking {

	int id;
	int max;
	int occupe;
	String adresse;
	
	public Parking(int id, int max, String adresse) {
		this.id = id;
		this.max = max;
		this.occupe = 0;
		this.adresse = adresse;
	}
	
	public boolean entre() {
		if(occupe<max) {
			occupe++;
			System.out.println("Une voiture entre dans le parking " + adresse);
			System.out.println("Il reste: " + (max-occupe));
			return true;
		} else {
			return false;
		}
	}
	
	public boolean sort() {
		if(occupe > 0) {
			occupe--;
			System.out.println("une voiture sort du parking " + adresse);
			System.out.println("Il reste: " + (max-occupe));
			return true;
		} else {
			return false;
		}
	}
	
	
}
