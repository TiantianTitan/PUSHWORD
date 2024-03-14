import java.util.Random;

public class ModelThread implements Runnable{

	Parkings parkings;
	Random randgen;
	
	public ModelThread(Parkings parkings) {
		this.parkings = parkings;
		randgen = new Random();
	}

	public void run() {
		while(true) {
			try {
				parkings.actionHasard();
				Thread.sleep(randgen.nextInt(250));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}			
		}
	}
}
