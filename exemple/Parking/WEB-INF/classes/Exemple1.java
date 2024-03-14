
public class Exemple1 {

	public static Parkings parkings1() {
		Parkings parkings1 = new Parkings();
		parkings1.ajouteParking(new Parking(1, 500, "rue Donald Trump"));
		parkings1.ajouteParking(new Parking(2, 40, "place Francky Vincent"));
		parkings1.ajouteParking(new Parking(3, 100, "Centre Commercial Patrick Balkany"));
		parkings1.ajouteParking(new Parking(4, 350, "rue Yannick Sayer"));
		parkings1.ajouteParking(new Parking(5, 10, "derriere le Gymnase Jean-Marie Messier"));
		return parkings1;
	}
	
}
