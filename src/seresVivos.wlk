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
	
	method recivirDanio(dmg) {
		vida -= dmg
	}
	
	method atacar()
	
	method danio()
	
	method estaEnfrente()
}


object hero inherits Mortal {
	
	var property position = game.center()
	var property image = "pepita.png"
	const inventario = []
	const equipo = []
	
	
	

	method agarrarItem(item) {
		item.serAgarrado()
		inventario.add(item)
	}
	
	override method danio() {
		equipo.sum(arma => arma.puntosDeDanio())
	}
	
	override method atacar() {
		//acá va a ir el visual para el sprite de atacar
		estaEnfrente().recivirDanio(self.danio())
	}
	
}

