import wollok.game.*
import seresVivos.*
import comandos.*

class Item  {
	
	var valor = 0
	var property image = "wheat.png"
	const property position = game.at(3,3)
	
	method solido() = false
	
	method serInteractuado(personaje){
		personaje.agarrarItem(self)
		game.removeVisual(self)
	}
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


