class Item  {
	
	//var valor
	
}

class Recurso inherits Item {
	
	
}

class Equipamento inherits Item {
	
	
}

class Arma inherits Equipamento {
	
	var puntosDeDanio
	
	method puntosDeDanio() = puntosDeDanio
}

class Armadura inherits Equipamento {
	
	var puntosDeArmadura
	
	method puntosDeArmadura() = puntosDeArmadura
}


