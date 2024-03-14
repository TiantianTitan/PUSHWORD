let titrepage = document.createElement("H1");
titrepage.textContent = "Authentification";
document.body.appendChild(titrepage);
let auth = document.createElement("FORM");
auth.setAttribute("action", "");
auth.setAttribute("method", "post");
auth.setAttribute("class", "authentification");
let ligne1 = document.createElement("DIV");
auth.appendChild(ligne1);
let lab1 = document.createElement("LABEL");
lab1.setAttribute("for", "login");
lab1.textContent = "Login:"
let inp1 = document.createElement("INPUT");
inp1.setAttribute("type", "text");
inp1.setAttribute("name", "login");
inp1.setAttribute("id", "login");
ligne1.appendChild(lab1);
ligne1.appendChild(inp1);
let ligne2 = document.createElement("DIV");
auth.appendChild(ligne2);
let lab2 = document.createElement("LABEL");
lab2.setAttribute("for", "mdp");
lab2.textContent = "Mot de Passe:"
let inp2 = document.createElement("INPUT");
inp2.setAttribute("type", "text");
inp2.setAttribute("name", "mdp");
inp2.setAttribute("id", "mdp");
ligne2.appendChild(lab2);
ligne2.appendChild(inp2);
let ligne3 = document.createElement("DIV");
auth.appendChild(ligne3);
let inp3 = document.createElement("INPUT");
inp3.setAttribute("type", "submit");
inp3.setAttribute("value", "Connexion");
ligne2.appendChild(inp3);
document.body.appendChild(auth);

function authentification(event, cont){

	let url = 'util?login='+inp1.value+'&mdp='+inp2.value;
	console.log("fetch a "+url);
	let headers = new Headers();
	headers.set('Accept', 'application/json');
	
	function chercher(){
		fetch(url, {method : "post", headers, mode : "same-origin"})
		.then(function(response){
			response.json()
			.then(function(rjson){
				console.log("Recu:" + rjson.resultat)
				cont(rjson);
			})
			.catch(function(error){console.log("Authentification Parsing: "+error.message)});
	    })
		.catch(function(error){
			console.log("Authentification Fetching: "+error.message);
		})
	}
	
	chercher();
	
}

function entree(rjson){
	document.body.removeChild(auth);
	if (rjson.resultat == "ok"){
		accueil(rjson.login)
	} else {
	if (rjson.resultat == "mdp"){
		document.body.innerHTML += "<h2 color=red> Mauvais mot de passe ! </h2>"
	}
	if (rjson.resultat == "login"){
		document.body.innerHTML += "<h2 color=red> Login inexistant. </h2>"
	}
	let bout = document.createElement("BUTTON")
	bout.textContent = "Reessayer";
	document.body.appendChild(bout);
	bout.addEventListener("click", function(_){console.log("Reessayer");document.location.reload();}) 
	}
}

function recupereUtil(login, cont){
	let xhr = new XMLHttpRequest();
	xhr.open('GET', 'util?login=' + login);
	xhr.send();
	xhr.addEventListener("readystatechange", function(event){	
		if (xhr.readyState === XMLHttpRequest.DONE) {
				let jresp = JSON.parse(xhr.response)
				cont(jresp)
				}
			})
}

function accueil(login){
	recupereUtil(login, accueil2);
}

function accueil2(util){
	console.log("Utilisateur: " + util.nom)
	console.log("Login: " + util.login)
	console.log("Emprunts: " + util.emprunts + " de longueur " + util.emprunts.length)
	titrepage.textContent = "Espace de "+ util.nom;
	let emprunts = document.createElement("SECTION");
	emprunts.textContent = "Emprunts en cours:";
	if(util.emprunts.length == 0){
		console.log("Aucun emprunt.")
		let aucun = document.createElement("section");
		aucun.setAttribute("id", "aucun");
		aucun.style.color = "#6699ff";
		aucun.textContent = "Aucun";
		emprunts.appendChild(aucun)
	} else {
		let listeEmprunts = document.createElement("UL");
		emprunts.appendChild(listeEmprunts);
		emprunts.setAttribute("id", "emprunts");
		for (emprunt of util.emprunts){
			let emprunt = document.createElement("LI");
			emprunts.textContent = emprunt.substrat.titre + " pour le " + emprunt.deadline;
			emprunts.appendChild(emprunt);}}
	document.body.appendChild(emprunts);
	
	let barreT = document.createElement("SECTION");
	barreT.textContent = "Recherche par Titre:";
	let inputbt = document.createElement("INPUT");
	inputbt.setAttribute("id", "inptitre");
	inputbt.setAttribute("type", "text");
	inputbt.setAttribute("name", "titre");
	barreT.appendChild(inputbt);
	let btsub = document.createElement("BUTTON");
	btsub.textContent = "Rechercher";
	btsub.addEventListener("click", event => appelRechercheTitre(util, event));
	barreT.appendChild(btsub);
	document.body.appendChild(barreT);
}
	
function presenteLivre(livre, util){
	let plivre = document.createElement("LI");
	plivre.textContent = livre.titre + "\n"
		+ "de " + livre.auteur + "\n"
		+ "edition de " + livre.publication + "\n";
	if(livre.disponible == 0){
		let aucun = document.createElement("DIV");
		aucun.textContent = "INDISPONIBLE";
		aucun.style.color = "red";
		plivre.appendChild(aucun);
	} else {
		let dispo = document.createElement("DIV");
		dispo.textContent = livre.disponible + " exemplaires disponible(s).";
		dispo.style.color = "green";
		plivre.appendChild(dispo);
		let bemprunter =  document.createElement("BUTTON");
		bemprunter.textContent = "Emprunter";
		bemprunter.addEventListener("click", event => emprunter(livre, util));
		plivre.appendChild(bemprunter);
	}
	
		
	return plivre
}


function emprunter(livre, util){
	let url = "emprunt?livre="+livre.id+"&login="+util.login;
	let headers = new Headers();
	headers.set('Accept', 'application/json');
	fetch(url, {method : "put", headers, mode : "same-origin"})
	.then(function(response){
		response.json()
		.then(function(rjson){
			console.log("Recu:" + rjson.resultat)
			cont(rjson);
		})
		.catch(function(error){console.log("Emprunt Parsing: "+error.message)});
    })
	.catch(function(error){
		console.log("Emprunt Fetching: "+error.message);
	})
}

function appelRechercheTitre(util, event){
	precRes = document.getElementById("resT")
	if(precRes != null){document.body.removeChild(precRes)}; 
	let titre = document.getElementById("inptitre").value;
    $.ajax({
        url : 'livres?titre='+ titre,
        type : 'GET',
        datatype : "json",
        success : x => resultatTitre(util, x, titre)
     });
	
}

function resultatTitre(util, resultat, titre){
	let resT = document.createElement("SECTION");
	resT.setAttribute("id", "resT");
	resT.textContent = "Resultats pour le titre:  " + titre;
	if(resultat.length == 0){
		console.log("Aucun resultat.")
		let aucunT = document.createElement("section");
		aucunT.setAttribute("id", "aucun");
		aucunT.style.color = "red";
		aucunT.textContent = "Aucun";
		resT.appendChild(aucunT)
	} else {
		let listeLivres = document.createElement("UL");
		resT.appendChild(listeLivres);
		listeLivres.setAttribute("id", "listeLivres");
		for (livre of resultat){
			listeLivres.appendChild(presenteLivre(livre, util));}}
	document.body.appendChild(resT);

}

auth.addEventListener("submit", function(event)
		{event.preventDefault(); 
		console.log("Connexion."); 
		authentification(event, entree)});




