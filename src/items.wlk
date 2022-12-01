
import wollok.game.*

class Item {

	var property valor = 0

	method serInteractuado(personaje) {
		personaje.agarrarItem(self)
		game.removeVisual(self)
	}

	method comprar(serVivo) {
	}

}

class Recurso inherits Item {

}

class Arma inherits Item {

	var danioBase = 50

	method puntosDeDanio() = danioBase + self.danioDeArma()
	
	method mejorarArma(mejora) {
		danioBase += mejora
	}
	
	method danioDeArma()

}

//ITEMS
object espada inherits Arma {

	override method valor() {
		return 100
	}
	
	override method danioDeArma() = 50

}

object baculo inherits Arma {

	override method valor() {
		return 150
	}
	
	override method danioDeArma() = 25
}

object piedra inherits Item {

	override method valor() {
		return 25
	}

}

object madera inherits Item {

	override method valor() {
		return 80
	}

}