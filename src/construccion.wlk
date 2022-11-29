import wollok.game.*
import seresVivos.*
import escenarios.*
import items.*

class Construccion inherits Solido {

	var property inventario = []

	method serInteractuado(personaje)

	// method validarSerUtilizado()
	// lo comento porque no creo que vayamos a usarlo-Agus
	method comprar(serVivo)

	method vender(serVivo)

	method montoACobrar() {
		return inventario.sum({ item => item.valor() })
	}

	method validarAccion(serVivo)

	method depositar(item) {
		inventario.add(item)
	}

	method consultar(serVivo)

}

object construccionBanco inherits Construccion (image = "Banco.png", position = game.at(2, 8)) {

	var property boveda = 0

	// Esto deberia de estar en clase construccion e invocarlo con un new supongo
	override method serInteractuado(personaje) {
		personaje.usarBanco(self)
	}

//	override method validarSerUtilizado() {
//	}
	override method accionAlSerColisionado() {
		mapaActual.cambiarMapa(construccionBancoInterior)
	}

	method consultar(serVivo) {
		game.say(self, "Tenes " + serVivo.oro() + " monedas de oro")
	}

	override method validarAccion(serVivo) {
		if (self.boveda() == 0) {
			self.error("No tenes oro para retirar")
		}
	}

	// SE DEPOSITA/RETIRA TODO EL ORO
	override method comprar(serVivo) { // equivalente a depositar
		serVivo.validarOroDisponible()
		boveda = +serVivo.oro()
		serVivo.oro(0)
		game.say(self, "Depositaste " + boveda + " oro")
	}

	override method vender(serVivo) { // equivalente a retirar
		self.validarAccion(serVivo)
		game.say(self, "Retiraste " + boveda + " oro")
		serVivo.oro(self.boveda())
		boveda = 0
	}

//hacer objeto que muestre la cantidad de oro encima toedo el tiempo (sugerencia de leo) -agus
}

object construccionMercado inherits Construccion (image = "Mercado.png", position = game.at(1, 2)) {

	override method serInteractuado(personaje) {
		personaje.usarMercado(self)
	}

	override method validarAccion(serVivo) {
		if (!serVivo.poseePiedras()) {
			self.error("Parece que no tenes piedras para vender!")
		}
	}

	method validarMadera(serVivo) {
		if (!serVivo.poseeMadera()) {
			self.error("Parece que no tenes madera para vender!")
		}
	}

	override method comprar(serVivo) { // opcion 1
		self.validarAccion(serVivo)
		const ganancia = serVivo.gananciaPorItemsVendidos(piedra)
		serVivo.borrarItems(piedra)
		serVivo.ganarOroPorVenta(ganancia)
		game.say(self, "Ganaste " + ganancia + " monedas de oro por tus piedras!")
	}

	override method vender(serVivo) { // opcion 2
		self.validarMadera(serVivo)
		const ganancia = serVivo.gananciaPorItemsVendidos(madera)
		serVivo.ganarOroPorVenta(ganancia)
		serVivo.borrarItems(madera)
		game.say(self, "Ganaste " + ganancia + " monedas de oro por tu madera!")
	}

	override method consultar(serVivo) {
		game.say(self, serVivo.inventario().toString())
	}

//	override method validarSerUtilizado() {
//	}
}

object construccionMagia inherits Construccion (image = "Magia.png", position = game.at(9, 8)) {

	override method serInteractuado(personaje) {
	}

	override method comprar(serVivo) {
	}

	override method vender(serVivo) {
	}

//	override method validarSerUtilizado() {
//	}
}

object construccionArmadura inherits Construccion (image = "Armaduras.png", position = game.at(12, 7)) {

	override method serInteractuado(personaje) {
	}

	override method comprar(serVivo) {
	}

	override method vender(serVivo) {
	}

//	override method validarSerUtilizado() {
//	}
}

