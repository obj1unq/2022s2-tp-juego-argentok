import wollok.game.*

class Item {

	var property valor = 0
	var property image = "wheat.png"
	const property position = game.at(3, 3)

	method solido() = false

	method serInteractuado(personaje) {
		// personaje.agarrarItem(self) este metodo se reemplaza por agarrarItemdeUnaCasa
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

class Casa {

	var property inventario = []
	// uso lista porque puede que hayan repetidos y los quiero conservar -- revisable
	var property image

	method comprar(serVivo, item)

	method vender(serVivo, item)

	method depositar(item) {
		inventario.add(item)
	}

	method retirar(item) {
		self.validarExistencia(item)
		inventario.remove(item)
	}

	method puedeInteractuar(serVivo)

	method validarExistencia(item) {
		if (not inventario.contains(item)) {
			self.error("No tengo el objeto que buscas")
		}
	}

}

class Banco inherits Casa {

	var property boveda = 0 // en la boveda va el oro

	override method image() {
		return "Banco.png"
	}

	override method puedeInteractuar(serVivo) {
		serVivo.usarBanco()
	}

	method consultarOro(serVivo) {
		game.say(self, "Tenes " + serVivo.oro() + "monedas de oro")
	}

	method depositarOro(cantOro, serVivo) {
		serVivo.reservarOro(cantOro)
		boveda = +cantOro
	}

	method retirarOro(cantOro) {
		self.validarCantidad(cantOro)
		boveda = -cantOro
	}

	method validarCantidad(cantOro) {
		if (cantOro > boveda) {
			self.error("No tenes tanto oro para retirar")
		}
	}

}

class CasaDeMagia inherits Casa {

	override method image() {
		return "Magia.png"
	}

	override method puedeInteractuar(serVivo) {
		serVivo.usarCasaDeMagia()
	}

	// las acciones de compra y venta son desde la casa, o sea, la casa es la que vende/compra
	override method comprar(serVivo, item) {
		self.validarCompraVenta(item, serVivo)
		serVivo.dejarItemEnUnaCasa(item, self) // el ser vivo ya no tiene el item y ahora lo tiene la casa
	}

	override method vender(serVivo, item) {
		serVivo.agarrarItemDeUnaCasa(item, self) // el ser vivo agarra el item y la casa ya no lo tiene mas
		serVivo.ganarOroPorVenta(item.valor())
	// aca podria haber un mensaje visual diciendo Vendiste tal cosa sumas tanto oro
	}

//no valido que exista el item porque damos por sentado que todos los mercados tienen todos los items disponibles
	method validarCompraVenta(item, serVivo) {
		if (item.valor() > serVivo.oro()) {
			self.error("No tenes oro suficiente para comprar este item")
		}
	}

}

class CasaDeArmaduras inherits CasaDeMagia {

	override method image() {
		return "Armaduras.png"
	}

	override method puedeInteractuar(serVivo) {
		serVivo.usarCasaDeArmaduras()
	}

}

class Mercado inherits CasaDeMagia {

	override method image() {
		return "Mercado.png"
	}

	override method puedeInteractuar(serVivo) {
		serVivo.usarMercado()
	}

}

