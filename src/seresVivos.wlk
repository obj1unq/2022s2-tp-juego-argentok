import wollok.game.*
import items.*
import comandos.*
import escenarios.*

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
		return direccion.siguiente(position).x().between(0, 14)
	}

	method validarEjeY(direccion) {
		// return direccion.siguiente(self.position()).y() != -1 and direccion.siguiente(self.position()).y() != 10
		return direccion.siguiente(position).y().between(0, 9)		
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
	
	// var property position = game.center()
	// var property image = "hero.png"
	
	
	const inventario = []
	const faime = [0,0,0,0,0] //fuerza, agilidad, inteligencia, mana, experiencia
	var armaduraEquipada = null
	var armaEquipada = null
	var property oro
	
	
	
	
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
		return armaEquipada.puntosDeDanio() + 10 * faime.first()
	}
	
	method armadura() {
		return armaduraEquipada.puntosDeArmadura() + 5 * faime.get(2)
	}
	
	
	override method atacar() {
		//acá va a ir el visual para el sprite de atacar

		//estaEnfrente().recibirDanio(self.danio())
		self.estaEnfrente(ultimaDireccion).first().recibirDanio(self.danio())

	}
	
	method dejarItemEnUnaCasa(item, casa){ 
		inventario.remove(item)
		casa.depositar(item)
	}
	
	method agarrarItemDeUnaCasa(item, casa){
		casa.retirar(item)
		inventario.add(item)
	}
	
	method reservarOro(cantOro){
		self.validarOroDisponible(cantOro)
		oro =- cantOro
	}
	method validarOroDisponible(cantOro) {
		if (oro < cantOro){
			self.error("No tenes esa cantidad de oro para depositar")
		}
	}
	
	method ganarOroPorVenta(cantOro){
		oro =+ cantOro
	}
	

	
	// METODOS DE CAMBIO DE MAPA
	
	// TODAVIA NO SE COMO HACER PARA COMPARAR SI ESTA CON UN LIMITE, el problema viene porque quiero comparar una instancia a la lista de objetos posibles a colisionar
	
	/* 
	
	method cambioDeMapa(direccion){
		if (game.getObjectsIn(direccion.siguiente(self.position())) == #{}){
			
		}
	}
	*/
}



object guerrero inherits Heroe(oro=0) {
	
	method usarCasaDeMagia(casa){
		//deshabilitar botones, el guerrero no puede usar esta casa!
		//mostrar mensaje de que no puede acceder
	}
	
	method usarCasaDeArmaduras(){
		//habilitar botones
	}
	
	method usarBanco(){
		//habilitar botones
	}
	
	method usarMercado(){
		//habilitar botones
	}
}

object mago inherits Heroe(oro=0) {
	
	method usarCasaDeMagia(casa){
		//habilitar botones
	}
	
	method usarCasaDeArmaduras(){
		//deshabilitar botones, el mago no puede usar esta casa!
		//mostrar mensaje de que no puede acceder
	}
	
	method usarBanco(){
		//habilitar botones
	}
	
	method usarMercado(){
		//habilitar botones
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


