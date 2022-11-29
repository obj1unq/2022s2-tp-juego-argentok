import wollok.game.*
import seresVivos.*
import escenarios.*

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

	method consultarOro(serVivo) {
		game.say(self, "Tenes " + serVivo.oro() + " monedas de oro")
	}

	method validarRetiro() {
		if (self.boveda() == 0) {
			self.error("No tenes oro para retirar")
		}
	}

	// SE DEPOSITA/RETIRA TODO EL ORO
	override method comprar(serVivo) { // equivalente a depositar
		boveda = +serVivo.oro()
		serVivo.oro(0)
		game.say(self, "Depositaste " + boveda + " oro")
	}

	override method vender(serVivo) { // equivalente a retirar
		self.validarRetiro()
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

	override method comprar(serVivo) { // opcion 1
		serVivo.oro() - 15
	}

	override method vender(serVivo) { // opcion 2
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

