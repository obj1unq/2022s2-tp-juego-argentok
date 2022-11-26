
import wollok.game.*
import seresVivos.*
import comandos.*

class Item  
{
	var valor = 0
	var property image = "wheat.png"
	const property position = game.at(7,4)
	method solido() = false
	
	method serInteractuado(personaje){
		personaje.agarrarItem(self)
		game.removeVisual(self)
	}
	
	method accionAlSerColisionado(){
		// no lo puedo hacer abstracto porque instancio varias veces a solido
	}
	
	method recibirDanio(dmg) {}
	
}

class Recurso inherits Item 
{
	
	
}

class Equipamento inherits Item 
{
	
	
}

class Arma inherits Equipamento {
	
	var puntosDeDanio
	
	method puntosDeDanio() = puntosDeDanio
}

class Armadura inherits Equipamento {
	
	var puntosDeArmadura
	
	method puntosDeArmadura() = puntosDeArmadura
}


