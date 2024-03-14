import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;

public class Parkings {

	List<Parking> parkings;
	transient Random randgen;
	
	public Parkings() { 
		parkings = new ArrayList<>();
		randgen = new Random();
	}
	
	
	public Optional<Parking> trouveId(Integer id){
		Parking res = null;
		for(Parking parking : parkings)
		{
			if(parking.id == id){res = parking; break;}
		}
		return Optional.ofNullable(res);
	}
	
	
	public void ajouteParking(Parking p) {
		parkings.add(p);
	}
	
	public void entreHasard() {
		if(parkings.size() > 0) {
			parkings.get(randgen.nextInt(parkings.size())).entre();
		}
	}

	public void sortHasard() {
		if(parkings.size() > 0) {
			parkings.get(randgen.nextInt(parkings.size())).sort();
		}
	}
	
	public void actionHasard() {
		if(randgen.nextInt(3)>0) {
			entreHasard();
		} else {
			sortHasard();
		}
	}

}
