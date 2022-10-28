import wollok.game.*
import items.*
import comandos.*

class Solido {
	
	var property position = game.center()
	var property image = "pepita.png"
	
	method puedoPasar(direccion) {
		return self.siguientePosicionEsVacia(direccion) and self.validarEjeX(direccion) and self.validarEjeY(direccion)
	}

	method siguientePosicionEsVacia(direccion) {
		return game.getObjectsIn(direccion.siguiente(self.position())).isEmpty()
	}
	
	
	// los números finales a los siguientes metodos deben ser cambiados dependiendo el tamaño que tenga el mapa 
	method validarEjeX(direccion) {
		// return direccion.siguiente(self.position()).x() != -1 and direccion.siguiente(self.position()).x() != 10
		return direccion.siguiente(position).x().between(0, 4)
	}

	method validarEjeY(direccion) {
		// return direccion.siguiente(self.position()).y() != -1 and direccion.siguiente(self.position()).y() != 10
		return direccion.siguiente(position).y().between(0, 4)		
	}
	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}


class Mortal inherits Solido {
	
	var property vida = 0
	var ultimaDireccion = derecha
	
	
	
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
	
	method estaEnfrente(direccion) {
		return game.getObjectsIn(direccion.siguiente(self.position()))
	}
	
	method mover(direccion)
	
	
}


class Heroe inherits Mortal {
	
	const inventario = []
	const farim = [0,0,0,0,0] 
	var armaduraEquipada = null
	var armaEquipada = null
	
	
	
	
	override method mover(direccion) {
		if (self.puedoPasar(direccion)) {
			position = direccion.siguiente(self.position())
		}
		self.ultimaDireccion(direccion)
	}
	
	method ultimaDireccion(direccion) {
		ultimaDireccion = direccion
	} 
	
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
		return armaEquipada.puntosDeDanio() + 10 * farim.first()
	}
	
	method armadura() {
		return armaduraEquipada.puntosDeArmadura() + 5 * farim.get(2)
	}
	
	
	override method atacar() {
		//acá va a ir el visual para el sprite de atacar
		self.estaEnfrente(ultimaDireccion).first().recibirDanio(self.danio())
	}
}

//esto esa asi solamente con fines de prueba
object enemigo {
	
	var property position = game.at(2,2)
	var vida = 300
	var property image = "pepita.png"
	
	method recibirDanio(dmg) {
		vida -= dmg
		if (vida <= 0) game.removeVisual(self)
	}
	
	method vida() = vida
}

// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
