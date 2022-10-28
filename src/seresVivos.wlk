import wollok.game.*
import items.*

class Solido {
	
}


class Mortal inherits Solido {
	
	var property vida = 0
	
	
	method morir() {
		if (vida <= 0) {
			self.despawnear()		
		}
	}
	
	method despawnear() {
		game.removeVisual(self)
	}
	
	method recibirDanio(dmg) {
		vida -= dmg
	}
	
	method atacar()
	
	method danio()
	
	method estaEnfrente() {
		
	}
}


object hero inherits Mortal {
	
	var property position = game.center()
	var property image = "pepita.png"
	const inventario = []
	var armaduraEquipada = null
	var armaEquipada = null
	
	
	method armaEquipada(arma) {
		armaEquipada = arma 
	}
	
	method armaduraEquipada(armadura) {
		armaduraEquipada = armadura 
	}

	method agarrarItem(item) {
		item.serAgarrado()
		inventario.add(item)
	}
	
	method equiparItem(item) {
	 
	}
	
	override method danio() {
		return armaEquipada.puntosDeDanio()
	}
	
	method armadura() {
		return armaduraEquipada.puntosDeArmadura()
	}
	
	override method atacar() {
		//acá va a ir el visual para el sprite de atacar
		//estaEnfrente().recibirDanio(self.danio())
	}
	
	
}

