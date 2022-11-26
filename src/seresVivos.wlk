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
		return direccion.siguiente(position).x().between(0, 14)
	}

	method validarEjeY(direccion) {
		return direccion.siguiente(position).y().between(0, 9)		
	}
	
	method accionAlSerColisionado(){
		// no lo puedo hacer abstracto porque instancio varias veces a solido
	}
	
	
	method morir() {
		if (vida <= 0) {
			self.despawnear()	
			self.entregarExp()
			self.gameOver()	
		}
	}
	
	method despawnear() {
		game.removeVisual(self)
	}
	
	method gameOver()
	
	method entregarExp()
	
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
	
	// REVISAR, esto deberai de ser un objeto para que pueda mantener su informacion independientemente del mapa en el que esta.
	// Tampoco tiene sentido tener que instanciarlo varias veces 
	
	// var property position = game.center()
	// var property image = "hero.png"
	
	
	const inventario = []
	const farim = [0,0,0,0,0] 
	var armaduraEquipada = null
	var armaEquipada = null
	var experiencia = 0
	var nivel = 1

	
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
	
	method experiencia() = experiencia
	
	method nivel() = nivel
	
	method ganarExp(cantidad) {
		experiencia += cantidad
		self.subirNivel()
	}
	
	method subirNivel() {
		if (self.expNecesariaPorNivel() <= experiencia) {
			nivel += 1
			game.say(self, "Subi de nivel")
		}
	}
	
	method expNecesariaPorNivel() {
		return 1000 * nivel
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
	 
	method inventario() = inventario
	
	method equiparItem(item) {
	 
	}
	
	override method danio() {
		return armaEquipada.puntosDeDanio() + 10 * self.tipoDeDanio()
	}
	
	method armadura() {
		return armaduraEquipada.puntosDeArmadura() + 5 * farim.get(2)
	}
	
	method tipoDeDanio()
	
	override method entregarExp() {}
	
	
	override method atacar() {
		//acá va a ir el visual para el sprite de atacar

		if (! self.estaEnfrente().isEmpty()) {
			self.estaEnfrente().first().recibirDanio(self.danio())
		}
		
		//y aca tiene que ir una rama ELSE con el sprite de ataque (si se quiere)
		

	}
	// METODOS DE CAMBIO DE MAPA
	
	// TODAVIA NO SE COMO HACER PARA COMPARAR SI ESTA CON UN LIMITE, el problema viene porque quiero comparar una instancia a la lista de objetos posibles a colisionar
	
	/* 
	
	method cambioDeMapa(direccion){
		if (game.getObjectsIn(direccion.siguiente(self.position())) == #{}){
			
		
	}
	*/
	
	
	override method gameOver(){
		//aca tiene que ir la pantalla de Game Over
	}
}

class Mago inherits Heroe {
	override method tipoDeDanio() {
		return farim.get(4)
	}
}

class Guerrero inherits Heroe {
	override method tipoDeDanio() {
		return farim.first()	
	}
}


class Enemigo inherits Mortal {


//esto esa asi solamente con fines de prueba

	const expEntregada = 500
	
	var heroe = null
	
	override method recibirDanio(dmg) {
		super(dmg)
		self.morir() 
	}
	
	override method entregarExp() {
		heroe.ganarExp(expEntregada)
	}
	
	override method gameOver(){}
	
	method heroe(_heroe) = _heroe
	
	override method mover(asd){}
	override method atacar(){}
	override method danio() {}
}
