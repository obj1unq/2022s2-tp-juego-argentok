import wollok.game.*
import items.*
import comandos.*
import seresVivos.*

class Enemigo inherits Mortal {
	
	
	const expEntregadaBase = 50
	const oroEntregadoBase = 10
	const heroe = null
	var property sentidoActual 
	
	override method entregarRecompensa() {
		heroe.ganarExp(self.expEntregada())
		heroe.ganarOro(self.oroEntregado())
	}

	method expEntregada() {
		return (expEntregadaBase / heroe.nivel()).roundUp()
	}

	method oroEntregado() {
		return oroEntregadoBase 
	}

	override method gameOver() {
	}

	method heroe(_heroe) = _heroe

	override method atacar() {
		game.onTick(750, "disparar", {crear.hechizo(self).serInvocado(150, self.danio())})			
	}

	override method danio() {
		return 100
	}
	
	override method mover(direccion){
		if(self.puedoPasar(direccion)){
			self.position(direccion.siguiente(self.position()))	
		}
		self.ultimaDireccion(direccion)
	}
	
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
}

class EnemigoVertical inherits Enemigo {
	override method gameOver(){}
}

class EnemigoEstatico inherits Enemigo{
	override method gameOver(){}
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