import wollok.game.*
import items.*
import comandos.*
import seresVivos.*

class Enemigo inherits Mortal {

	var property sentidoActual 
	
	override method recibirDanio(dmg) {
		super(dmg)
		self.morir() 
	}
	
	override method mover(direccion){
		if(self.puedoPasar(direccion)){
			self.position(direccion.siguiente(self.position()))	
		}
		self.ultimaDireccion(direccion)
	}
	
	 //Deberia ser abstracto//
	override method atacar(){}
	override method danio() {}
	
	method moverse(){
		if(self.puedoPasar(sentidoActual)){
			self.mover(sentidoActual)
		}
		else{
			self.cambiarSiNoPuedePasar()
			self.mover(sentidoActual)
		}
	}
	method cambiarSiNoPuedePasar(){
		if(!self.puedoPasar(sentidoActual)){
			sentidoActual = direccionOpuesta.opuesto(self)
		}
	}
	
	method sentidoActualEs(direccion){
		return direccion == sentidoActual
	}
}

class EnemigoHorizontal inherits Enemigo {
	override method gameOver(){}
	override method entregarExp(){}
}

class EnemigoVertical inherits Enemigo {
	override method gameOver(){}
	override method entregarExp(){}
}

class EnemigoEstatico inherits Enemigo{
	override method gameOver(){}
	override method entregarExp(){}
}

object direccionOpuesta {
	
	method opuesto(enemigo){
		if(enemigo.sentidoActualEs(izquierda)){
			return derecha
		}
		else if(enemigo.sentidoActualEs(derecha)){
			return izquierda
		}
		else if(enemigo.sentidoActualEs(arriba)){
			return abajo
		}
		else if(enemigo.sentidoActualEs(abajo)){
			return arriba
		}
		else{
			return null
		}
	}
}