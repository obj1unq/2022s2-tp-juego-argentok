import wollok.game.*
import seresVivos.*
import escenarios.*
import items.*

class Construccion inherits Solido {

	var property inventario = [ baculo ]
	var property boveda = 0

	method serInteractuado(personaje)

	// method validarSerUtilizado()
	// lo comento porque no creo que vayamos a usarlo-Agus
	method comprar(serVivo)

	method vender(serVivo)

	method montoACobrar() {
		return inventario.sum({ item => item.valor() })
	}

	method validarOpcionUno(serVivo)

	method validarOpcionDos(serVivo)

	method validarOpcionTres(serVivo)

	method depositar(item) {
		inventario.add(item)
	}

	method consultar(serVivo)

	method valorDelInventario() {
		return inventario.sum({ item => item.valor() })
	}

	method valorDeLosItems(_item) {
		return inventario.count({ item => item == _item }) * _item.valor()
	}

	method todosLosItemsDelTipo(_item) {
		return inventario.filter({ item => item == _item })
	}

	method borrarTodosLosItemsDelTipo(_item) {
		inventario.removeAllSuchThat({ item => item == _item})
	}

	method mejorarDanio(serVivo) {
		return serVivo.puntosDeDanioDelArmaActual() * 10
	}

}

object construccionBanco inherits Construccion (image = "Banco.png", position = game.at(2, 8)) {

	// Esto deberia de estar en clase construccion e invocarlo con un new supongo
	override method serInteractuado(personaje) {
		personaje.usarBanco(self)
	}

//	override method validarSerUtilizado() {
//	}
	override method accionAlSerColisionado() {
		mapaActual.cambiarMapa(construccionBancoInterior)
	}

	override method consultar(serVivo) {
		game.say(self, "Tenes " + serVivo.oro() + " monedas de oro")
	}

	// SE DEPOSITA/RETIRA TODO EL ORO
	override method comprar(serVivo) { // equivalente a depositar
		self.validarOpcionUno(serVivo)
		boveda = +serVivo.oro()
		serVivo.oro(0)
		game.say(self, "Depositaste " + boveda + " oro")
	}

	override method vender(serVivo) { // equivalente a retirar
		self.validarOpcionDos(serVivo)
		game.say(self, "Retiraste " + boveda + " oro")
		serVivo.oro(self.boveda())
		boveda = 0
	}

	override method validarOpcionUno(serVivo) {
		if (serVivo.oro() == 0) {
			self.error("No tenes oro para depositar!")
		}
	}

	override method validarOpcionDos(serVivo) {
		if (self.boveda() == 0) {
			self.error("No tenes oro para retirar")
		}
	}

	override method validarOpcionTres(serVivo) {
	}

//hacer objeto que muestre la cantidad de oro encima toedo el tiempo (sugerencia de leo) -agus
}

object construccionMercado inherits Construccion (image = "Mercado.png", position = game.at(1, 2)) {

	override method serInteractuado(personaje) {
		personaje.usarMercado(self)
	}

	override method validarOpcionUno(serVivo) {
		if (!serVivo.poseePiedras()) {
			self.error("Parece que no tenes piedras para vender!")
		}
	}

	override method validarOpcionDos(serVivo) {
		if (!serVivo.poseeMadera()) {
			self.error("Parece que no tenes madera para vender!")
		}
	}

	override method comprar(serVivo) { // opcion 1
		self.validarOpcionUno(serVivo)
		const ganancia = serVivo.gananciaPorItemsVendidos(piedra)
		serVivo.borrarItems(piedra)
		serVivo.ganarOroPorVenta(ganancia)
		game.say(self, "Ganaste " + ganancia + " monedas de oro por tus piedras!")
	}

	override method vender(serVivo) { // opcion 2
		self.validarOpcionDos(serVivo)
		const ganancia = serVivo.gananciaPorItemsVendidos(madera)
		serVivo.ganarOroPorVenta(ganancia)
		serVivo.borrarItems(madera)
		game.say(self, "Ganaste " + ganancia + " monedas de oro por tu madera!")
	}

	override method consultar(serVivo) {
		game.say(self, "En tu inventario hay " + serVivo.inventario().toString())
	}

	override method validarOpcionTres(serVivo) {
	// diosbendigaelpolimorfismo
	}

//	override method validarSerUtilizado() {
//	}
}

object construccionMagia inherits Construccion (image = "Magia.png", position = game.at(9, 8)) {

	override method serInteractuado(personaje) {
		personaje.usarCasaDeMagia(self)
	}

	override method comprar(serVivo) { // comprar baculo
		self.validarOpcionUno(serVivo)
		serVivo.oro(serVivo.oro() - baculo.valor())
		const ganancia = baculo.valor()
		boveda = +ganancia
		serVivo.agregar(self.todosLosItemsDelTipo(baculo))
		game.say(self, "Compraste un báculo! Gastaste " + ganancia + " monedas de oro")
		self.borrarTodosLosItemsDelTipo(baculo)
	}

	override method vender(serVivo) { // mejorar arma
		self.validarOpcionDos(serVivo)
		self.validarOpcionTres(serVivo)
		const nuevoDanio = self.mejorarDanio(serVivo)
		serVivo.oro(serVivo.oro() - 300)
		game.say(self, "El poder de daño de tu arma subió! Ahora es " + nuevoDanio)
	}

	override method validarOpcionUno(serVivo) {
		if (serVivo.oro() < baculo.valor()) {
			self.error("No tenes suficiente oro para comprar un báculo")
		} else if (self.todosLosItemsDelTipo(baculo).size() < 1) {
			self.error("No hay más báculos disponibles")
		}
	}

	override method validarOpcionDos(serVivo) {
		if (serVivo.armaActual() == null) {
			self.error("No tenes arma para mejorar")
		}
	}

	override method consultar(serVivo) {
		game.say(self, "Tenemos en stock: " + self.inventario().toString())
	}

	override method validarOpcionTres(serVivo) { // validamos que tenga oro suficiente para mejorar el arma
		if (serVivo.oro() < 300) {
			self.error("Se necesitan 300 monedas de oro para mejorar tu arma!")
		}
	}

//	override method validarSerUtilizado() {
//	}
}

object construccionArmadura inherits Construccion (image = "Armaduras.png", position = game.at(12, 7)) {

	override method serInteractuado(personaje) {
		personaje.usarCasaDeArmaduras(self)
	}

	override method comprar(serVivo) { // comprar espada
		self.validarOpcionUno(serVivo)
		serVivo.oro(serVivo.oro() - espada.valor())
		const ganancia = espada.valor()
		boveda = +ganancia
		serVivo.agregar(self.todosLosItemsDelTipo(espada))
		game.say(self, "Compraste una espada! Gastaste " + ganancia + " monedas de oro")
		self.borrarTodosLosItemsDelTipo(espada)
	}

	override method vender(serVivo) { // mejorar arma
		self.validarOpcionDos(serVivo)
		self.validarOpcionTres(serVivo)
		const nuevoDanio = self.mejorarDanio(serVivo)
		serVivo.oro(serVivo.oro() - 200)
		game.say(self, "El poder de daño de tu arma subió! Ahora es " + nuevoDanio)
	}

//	override method validarSerUtilizado() {
//	}
	override method validarOpcionUno(serVivo) {
		if (serVivo.oro() < espada.valor()) {
			self.error("No tenes suficiente oro para comprar una espada")
		} else if (self.todosLosItemsDelTipo(espada).size() < 1) {
			self.error("No hay más espadas disponibles")
		}
	}

	override method validarOpcionDos(serVivo) {
		if (serVivo.armaActual() == null) {
			self.error("No tenes arma para mejorar")
		}
	}

	override method validarOpcionTres(serVivo) {
		if (serVivo.oro() < 200) {
			self.error("Se necesitan 200 monedas de oro para mejorar tu arma!")
		}
	}

	override method consultar(serVivo) {
		game.say(self, "Tenemos en stock: " + self.inventario().toString())
	}

}

