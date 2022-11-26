import wollok.game.*
import items.*
import comandos.*
import escenarios.*


class Mortal {
	

	var property vida = 0
	var ultimaDireccion = null
	var property position = game.center()
	var property image = "pepita.png"
	
	method solido() = true
	
	method puedoPasar(direccion) {
		return self.noHaySolidosAdelante(direccion) and self.validarEjeX(direccion) and self.validarEjeY(direccion)
	}

	method noHaySolidosAdelante(direccion) {
		return self.losSolidos(game.getObjectsIn(direccion.siguiente(self.position()))).isEmpty()
	}
	
	method losSolidos(lista) {
		return lista.filter({cosa => cosa.solido()})
	}
	
	// los números finales a los siguientes metodos deben ser cambiados dependiendo el tamaño que tenga el mapa 
	method validarEjeX(direccion) {
		return direccion.siguiente(position).x().between(0, 4)
	}

	method validarEjeY(direccion) {
		return direccion.siguiente(position).y().between(0, 4)		
	}
	
	method accionAlSerColisionado(){
		// no lo puedo hacer abstracto porque instancio varias veces a solido
	}
	
	
	method morir() {
		if (vida <= 0) {
			self.despawnear()	
			self.gameOver()	
		}
	}
	
	method despawnear() {
		game.removeVisual(self)
	}
	
	method gameOver(){}
	
	method recibirDanio(dmg) {
		vida -= dmg
	}
	
	method atacar()
	
	method danio()
	
	method estaEnfrente() {
		return game.getObjectsIn(ultimaDireccion.siguiente(self.position()))
	}
	
	method mover(direccion)
	
	method ultimaDireccion(direccion) {
		ultimaDireccion = direccion
	} 
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
			self.estaEnfrente().forEach({objeto => objeto.accionAlSerColisionado()})
			
		}
		self.ultimaDireccion(direccion)
	}
	
	method arribaDe() {
		return game.getObjectsIn(self.position())
	}
	
	method armaEquipada(arma) {
		armaEquipada = arma 
	}
	
	method armaduraEquipada(armadura) {
		armaduraEquipada = armadura 
	}

	method interactuar(cosa) {
		cosa.serInteractuado(self)
	}
	
	method interactuarConTodos() {
		self.arribaDe().forEach({cosa => self.interactuar(cosa)})
	}
	
	method serInteractuado(alguien){}
	
	method agarrarItem(item) {
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
		self.estaEnfrente().first().recibirDanio(self.danio())

	}
	
	// METODOS DE CAMBIO DE MAPA
	
	// TODAVIA NO SE COMO HACER PARA COMPARAR SI ESTA CON UN LIMITE, el problema viene porque quiero comparar una instancia a la lista de objetos posibles a colisionar
	
	/* 
	
	method cambioDeMapa(direccion){
		if (game.getObjectsIn(direccion.siguiente(self.position())) == #{}){
			
		
	}
	*/
	
}


class Enemigo inherits Mortal {



//esto esa asi solamente con fines de prueba

	
	
	override method recibirDanio(dmg) {
		super(dmg)
		self.morir() 
	}
	
	override method mover(asd){}
	override method atacar(){}
	override method danio() {}
}
