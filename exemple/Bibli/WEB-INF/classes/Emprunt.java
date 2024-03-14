import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Emprunt {

	int id;
	Livre substrat;
	String deadline;
	String emprunteur;
	
	public Emprunt(int id,  String emprunteur, Livre substrat)
	{
		LocalDate dateDeadline = LocalDate.now().plusDays(30);
		this.id = id;
		this.deadline = dateDeadline.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		this.emprunteur = emprunteur;
		this.substrat = substrat;
	}

	public int joursRestants() {
		LocalDate dateDeadline = LocalDate.parse(deadline);
		int duree = (int) Duration.between(LocalDate.now(), dateDeadline).toDays();
		if(duree >= 0) {return duree;} else {return 0;}
	}
	
	public String toString() {
		return "";
	}	


}	
	
