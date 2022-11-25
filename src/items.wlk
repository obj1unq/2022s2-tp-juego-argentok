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

class Armadura inherits Equipamento {

	var puntosDeArmadura

	method puntosDeArmadura() = puntosDeArmadura

}

class Casa {

	var property inventario = []
	// uso lista porque puede que hayan repetidos y los quiero conservar -- revisable
	
	var property position 
	
	method image()
	
	method comprar(serVivo)

	method vender(serVivo)

//	method depositar(items) {
//		inventario.add(items)
//	}
//
//
//	method retirar(item) {
//		self.validarExistencia(item)
//		inventario.remove(item)
//	}

//	method validarExistencia(item) {
//		if (not inventario.contains(item)) {
//			self.error("No tengo el objeto que buscas")
//		}
//	}
//	
	method serInteractuado(serVivo)
	
}

class Banco inherits Casa {

	var property boveda = 0 // en la boveda va el oro

	override method image() {
		return "Banco.png"
	}

	override method serInteractuado(serVivo) {
		serVivo.usarBanco(self)
	}

	method consultarOro(serVivo) {
		game.say(self, "Tenes " + serVivo.oro() + " monedas de oro")
	}


	method validarRetiro() {
		if (self.boveda() == 0) {
			self.error("No tenes oro para retirar")
		}
	}
	//SE DEPOSITA/RETIRA TODO EL ORO
   	override method comprar(serVivo){//equivalente a depositar
   		boveda =+ serVivo.oro()
   		serVivo.oro(0)
   		game.say(self,"Depositaste " + boveda + " oro")
   	}

	override method vender(serVivo){//equivalente a retirar
		self.validarRetiro()
		game.say(self, "Retiraste " + boveda + " oro")
		serVivo.oro(self.boveda())
		boveda = 0
	}
//hacer objeto que muestre la cantidad de oro encima toedo el tiempo
}


class CasaDeMagia inherits Casa {

	
	
	override method image() {
		return "Magia.png"
	}

	override method serInteractuado(serVivo) {
		serVivo.usarCasaDeMagia(self)
	}

	// SE COMPRAN Y VENDEN TODOS LOS ITEMS
	override method comprar(serVivo) {
		self.validarCompraVenta(serVivo)
		serVivo.agregar(inventario) 
		game.say(self, "Compraste" + inventario)
	}


	
	override method vender(serVivo) {
		serVivo.ganarOroPorVenta(serVivo.valorDelInventario())
		serVivo.vaciarInventario()
	//TODO: pasar los items del inventario del ser vivo al inventario de la casa
	}

	method validarCompraVenta(serVivo) {
		if (self.montoACobrar() > serVivo.oro()) {
			self.error("No tenes oro suficiente para comprar este item")
		}else {
			serVivo.oro() - self.montoACobrar()
		}
	}

}

class CasaDeArmaduras inherits CasaDeMagia {

	override method image() {
		return "Armaduras.png"
	}

	override method serInteractuado(serVivo) {
		serVivo.usarCasaDeArmaduras(self)
	}
	
	override method comprar(serVivo){
		
	}

}

class Mercado inherits CasaDeMagia {

	override method image() {
		return "Mercado.png"
	}

	override method serInteractuado(serVivo) {
		serVivo.usarMercado(self)
	}

}



//ITEMS
object hechizo inherits Item{

}

object baculo inherits Item{

}


