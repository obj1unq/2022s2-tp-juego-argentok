
import wollok.game.*

class Item {

	var property valor = 0
	var property image = "wheat.png"
	const property position = game.at(3, 3)

	method solido() = false

	method serInteractuado(personaje) {
		personaje.agarrarItem(self)
		game.removeVisual(self)
	}

	method comprar(serVivo) {
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

//ITEMS
object espada inherits Item {

	override method valor() {
		return 100
	}

}

object baculo inherits Item {

	override method valor() {
		return 150
	}

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