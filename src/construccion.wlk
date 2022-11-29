import wollok.game.*
import seresVivos.*
import escenarios.*
import items.*

class Construccion inherits Solido {

	var property inventario = [ baculo, hechizo ]
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

	override method comprar(serVivo) { // comprar hechizo
		self.validarOpcionUno(serVivo)
		const ganancia = self.valorDeLosItems(hechizo)
		serVivo.oro(serVivo.oro() - self.valorDeLosItems(hechizo))
		boveda = +ganancia
		serVivo.agregar(self.todosLosItemsDelTipo(hechizo))
		game.say(self, "Compraste " + self.todosLosItemsDelTipo(hechizo).size() + " hechizos")
		self.borrarTodosLosItemsDelTipo(hechizo)
	}

	override method vender(serVivo) { // comprar baculo 
		self.validarOpcionDos(serVivo)
		serVivo.oro(serVivo.oro() - self.valorDeLosItems(baculo))
		const ganancia = self.valorDeLosItems(baculo)
		boveda = +ganancia
		serVivo.agregar(self.todosLosItemsDelTipo(baculo))
		game.say(self, "Compraste un báculo!")
		self.borrarTodosLosItemsDelTipo(baculo)
	}

	override method validarOpcionUno(serVivo) {
		if (serVivo.oro() < hechizo.valor()) {
			self.error("No tenes suficiente oro para comprar hechizos")
		} else if (self.todosLosItemsDelTipo(hechizo).size() < 1) {
			self.error("No hay más hechizos disponibles")
		}
	}

	override method validarOpcionDos(serVivo) {
		if (serVivo.oro() < baculo.valor()) {
			self.error("No tenes suficiente oro para comprar un báculo")
		} else if (self.todosLosItemsDelTipo(hechizo).size() < 1) {
			self.error("No hay más báculos disponibles")
		}
	}

	override method consultar(serVivo) { // mejorar arma
		self.validarArma(serVivo)
		self.validarOpcionTres(serVivo)
		const nuevoDanio = self.mejorarDanio(serVivo)
		serVivo.oro(serVivo.oro() - 300)
		game.say(self, "El poder de daño de tu arma subió! Ahora es " + nuevoDanio)
	}

	method validarArma(serVivo) {
		if (serVivo.armaActual() == null) {
			self.error("No tenes arma para mejorar")
		}
	}

	method mejorarDanio(serVivo) {
		return serVivo.puntosDeDanioDelArmaActual() * 10
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

	override method comprar(serVivo) {
	}

	override method vender(serVivo) {
	}

//	override method validarSerUtilizado() {
//	}
	override method validarOpcionUno(serVivo) {
	}

	override method validarOpcionDos(serVivo) {
	}

	override method validarOpcionTres(serVivo) {
	}

	override method consultar(serVivo) {
	}

}

