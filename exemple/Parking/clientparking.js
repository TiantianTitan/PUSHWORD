function recupereParking(){
	
	let url = 'siniti';
	let headers = new Headers();
	headers.set('Accept', 'application/json');
	
	fetch(url, {method : "get", headers, mode : "same-origin"})
	.then(function(response){
		response.json()
		.then(function(rjson){
			structure(rjson.parkings)
		})
		.catch(function(error){console.log("Parkings Parsing: " +error.message)});
	})
	.catch(function(error){
		console.log("Parkings Fetching: "+error.message);
	})

}

function recupereRestant(id, cont){
	let url = 'restant?id='+id;
	
	fetch(url, {method : "get", mode : "same-origin"})
	.then(function(response){
		response.text().then(cont).catch(function(error){console.log("Parking Parsing: "+error.message);})
	})
	.catch(function(error){
		console.log("Parking Fetching: "+error.message);
	})

}

class ValeurParking extends React.Component {
  constructor(props) {
    super(props);
    console.log(props.id);
    const restante = parseInt(props.max - props.occupe);
    console.log(restante);
    this.state = { valeur: restante };
  }

  componentDidMount() {
	let pid = this.props.id
	const sState = this.setState.bind(this)
	this.interval = setInterval(function(){ 
		recupereRestant( pid , function(x){sState({ valeur: x })})
											}, 1000);
  }
  

  componentWillUnmount() {
	  clearInterval(this.interval);
	}
  
  render() {
	  return React.createElement('div',
			  {style : {color: couleur(this.props.max, this.state.valeur)}},
			  this.state.valeur)
  }
}

function couleur(m, v){
	  const p = v * 100 / m;
	  if(p > 50) {return "green"}
	  else if(p> 10) {return "#ff9933"}
	  else if(p> 0) {return "red"}
	  else {return "#660033"}
}


function structure(parkings){

	for (parking of parkings){
		console.log("Parking id" + parking.id)
		let iparking = document.createElement("DIV");
		iparking.textContent = "Parking " + parking.adresse + ": ";
		let iparkingvalue = document.createElement("DIV");
		iparking.appendChild(iparkingvalue)
		ReactDOM.render(
				React.createElement(ValeurParking, {id: parking.id, 
													max: parking.max, 
													occupe: parking.occupe,
													}, null),
				iparkingvalue
		);
		iparking.appendChild(document.createElement("BR"))
		document.body.appendChild(iparking);		
	}
	
	let meilleur = document.createElement("DIV");
	meilleur.textContent = "Meilleur Parking : ";
	
}

console.log("Demarrage.")
recupereParking()