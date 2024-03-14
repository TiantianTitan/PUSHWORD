import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class BaseEmprunts {

	Map<Integer, Emprunt> base;
	
	public BaseEmprunts() {
		base = new HashMap<>();
	}
	
	public Optional<Emprunt> trouveEmprunt(int i){
		Integer id = (Integer) i;
		Emprunt res = null;
		for (Emprunt e : base.values()) {
			Integer j = (Integer) e.id;
			if(j.equals(id)){res = e; break;}
		};
		return Optional.ofNullable(res);
	}

	public void ajouteEmprunt(Emprunt e) {
		base.put(e.id, e);
	}

	public void retireEmprunt(Emprunt e) {
		base.remove(e.id);
	}

	
}
