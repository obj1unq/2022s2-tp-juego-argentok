import wollok.game.*
import items.*
import seresVivos.*
import escenarios.*
import estadisticas.*
import comandos.*


class Enemigo inherits Mortal {
	
	
	const expEntregadaBase = 50
	const oroEntregadoBase = 10
	var sentidoActual
	
	override method entregarExp(){
		// PONGO ESTE METODO EN BLANCO PORQUE SINO NO FUNCA BIEN, MORTAL TIENE ES METODO
	}
	
	
	override method entregarRecompensa() {
		configuracion.heroe().ganarExp(self.expEntregada())
		configuracion.heroe().ganarOro(self.oroEntregado())
	}

	method expEntregada() {
		return (expEntregadaBase / configuracion.heroe().nivel()).roundUp()
	}

	method oroEntregado() {
		return oroEntregadoBase 
	}

	override method gameOver() {
	}
	
	override method morir() {
		super() 
		game.removeTickEvent("atacar")
	}
	
	method atacarCadaTanto() {
		game.onTick(750, "atacar", {self.atacar()})
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
	
	method cambiarImagen() {
		self.image(self.imagenActual()) 
	}
	
	method imagenActual() {
		return "esqueleto_" + sentidoActual.toString() + ".png" 
	}
	
	method movimiento() {
		game.onTick(1000, "moverse", {self.moverse()})
	}
	
	method moverse(){
		if(self.puedoPasar(sentidoActual)){
			self.mover(sentidoActual)
		}
		else{
			self.cambiarSiNoPuedePasar()
			self.cambiarImagen()
			self.mover(sentidoActual)
		}
	}
	method cambiarSiNoPuedePasar(){
		if(!self.puedoPasar(sentidoActual)){
			sentidoActual = sentidoActual.opuesto()
		}
	}
	
	method sentidoActualEs(direccion){
		return direccion == sentidoActual
	}
}