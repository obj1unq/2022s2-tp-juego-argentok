import wollok.game.*
import items.*
import comandos.*
import escenarios.*

class Solido {
	
	/*
	No creo que este bien que mortal herede de solido, hay metodos que la mayorai de solidos no van a usar como validar los ejes o siguiente posicion es vacia.
	Tambien mi idea es que cada solido pueda devolver .mapa() que me retorne de que mapa
	*/
	
	var property position = game.center()
	var property image = "pepita.png"
	
	method puedoPasar(direccion) {
		return self.siguientePosicionEsVacia(direccion) and self.validarEjeX(direccion) and self.validarEjeY(direccion)
	}

	method siguientePosicionEsVacia(direccion) {
		return game.getObjectsIn(direccion.siguiente(self.position())).isEmpty()
	}
	
	method objetosEnDireccion(direccion){
		return game.getObjectsIn(direccion.siguiente(self.position()))
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

	
	method accionAlSerColisionado(){
		// no lo puedo hacer abstracto porque instancio varias veces a solido
	}
	
	

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
	
	// REVISAR, esto deberai de ser un objeto para que pueda mantener su informacion independientemente del mapa en el que esta. Tampoco tiene sentido tener que instanciarlo varias veces 
	
	// var property position = game.center()
	// var property image = "hero.png"
	
	
	const inventario = []
	const farim = [0,0,0,0,0] 
	var armaduraEquipada = null
	var armaEquipada = null
	
	
	
	
	override method mover(direccion) {
		
		
		
		if (self.puedoPasar(direccion)) {
			position = direccion.siguiente(self.position())
		}
		else{
			self.objetosEnDireccion(direccion).forEach({objeto => objeto.accionAlSerColisionado()})
			
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

		//estaEnfrente().recibirDanio(self.danio())
		self.estaEnfrente(ultimaDireccion).first().recibirDanio(self.danio())

	}
	
	// METODOS DE CAMBIO DE MAPA
	
	// TODAVIA NO SE COMO HACER PARA COMPARAR SI ESTA CON UN LIMITE, el problema viene porque quiero comparar una instancia a la lista de objetos posibles a colisionar
	
	/* 
	
	method cambioDeMapa(direccion){
		if (game.getObjectsIn(direccion.siguiente(self.position())) == #{}){
			
		
	}
	*/
	
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


