import wollok.game.*
import items.*
import comandos.*
import seresVivos.*

class Enemigo inherits Mortal {

	var property sentidoActual = derecha
	var property siguientePosicion = sentidoActual.siguiente(self.position())
	
//esto esa asi solamente con fines de prueba

	
/*method siguientePosicion(){
		return sentidoActual.siguiente(self.position())
	}*/
	
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
	
	method moverHacia(direccion){
		game.onTick(500, "moverHacia", {self.mover(direccion)})
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
	method cambiarSiNoPuedePasar(){}
	
	/*method irHastaElFondoDerecha(){
		if(self.puedoPasar(derecha)){
			self.moverHacia(derecha)
		} else{
			game.removeTickEvent("moverHacia")
			self.irHastaElFondoIzquierda()
		}
	}
	method irHastaElFondoIzquierda() {
		if(self.puedoPasar(izquierda)){
			self.moverHacia(izquierda)
		} else{
			game.removeTickEvent("moverHacia")
			self.irHastaElFondoDerecha()
		}
	}*/
}

class EnemigoHorizontal inherits Enemigo {

	override method cambiarSiNoPuedePasar(){
		if(!self.puedoPasar(sentidoActual)){
			//sentidoActual = izquierda
			sentidoActual = direccionOpuesta.direccion(sentidoActual)
		}
		else if(!self.puedoPasar(izquierda)){
			//sentidoActual = derecha
			sentidoActual = direccionOpuesta.direccion(sentidoActual)
		}
	}
	
}

object direccionOpuesta {
	
	method direccion(direccion){
		if(direccion == izquierda){
			return derecha
		}
		else if(direccion == derecha){
			return izquierda
		}
		else{
			return null
		}
	}
}

class EnemigoVertical inherits Enemigo {

	/*override method cambiarSiNoPuedePasar(){
		if(!self.puedoPasar(sentidoActual)){
			sentidoActual = abajo
		}
	}*/
}

class EnemigoEstatico inherits Enemigo{
	
		//Este enemigo ataca solo a la posicion hacia adelante//
}
