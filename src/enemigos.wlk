import wollok.game.*
import items.*
import seresVivos.*
import escenarios.*
import estadisticas.*
import comandos.*


class Enemigo inherits Mortal {
	
	
	const expEntregadaBase = 50
	const oroEntregadoBase = 10
	var property velocidadDeMov = 750
	var sentidoActual
	
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
	
	override method despawnear() {
		super()
		game.removeTickEvent("esqueleto_ataca")
		game.removeTickEvent("esquelet_se_mueve")
	}
	
	method atacarAlHeroe() {
		if(self.heroeEstaCerca()) {
			game.removeTickEvent("esquelet_se_mueve")
			self.mover(derecha.darDireccion(self.dondeEstaElHeroe(), self.position()))
			self.atacarCadaTanto()
		}
	}
	
	method dondeEstaElHeroe() {
		return configuracion.heroe().position()
	}
	
	method heroeEstaCerca() {
		
		const direcciones = [izquierda, derecha, abajo, arriba]
		
		return direcciones.any({direccion => self.dondeEstaElHeroe() == direccion.siguiente(self.position())})
	}
	
	method atacarCadaTanto() {
		game.onTick(750, "esqueleto_ataca", {self.atacar()})
	}

	override method danio() {
		return 100
	}
	method cambiarImagen() {
		self.image(self.imagenActual("")) 
	}
	
	method imagenActual(string) {
		return "esqueleto_" + self.ultimaDireccion().toString() + string + ".png" 
	}
	
	method selfstring() {
		return self.toString()
	}
	
	override method spriteDeAtaque() {
		self.image(self.imagenActual("_espada"))
		game.schedule(125, {self.image(self.imagenActual(""))})
	}
	
	override method mover(direccion){
		if(self.puedoPasar(direccion)){
			self.position(direccion.siguiente(self.position()))	
		}
		self.ultimaDireccion(direccion)
		self.cambiarImagen()
		
	}
	
	method movimiento() {
		game.onTick(velocidadDeMov, "esquelet_se_mueve", {self.patrulla()})
	}
	
	method patrulla() {
		self.moverse()
		self.atacarAlHeroe()		
	}
	
	method moverse(){
		if(self.puedoPasar(sentidoActual)){
			self.mover(sentidoActual)
		}
		else{
			self.cambiarSiNoPuedePasar()
//			self.cambiarImagen()
			self.mover(sentidoActual)
		}
	}
	method cambiarSiNoPuedePasar(){
		if(!self.puedoPasar(sentidoActual)){
			sentidoActual = sentidoActual.opuesta()
		}
	}
	
	method sentidoActualEs(direccion){
		return direccion == sentidoActual
	}
}