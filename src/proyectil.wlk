import wollok.game.*
import items.*
import seresVivos.*
import escenarios.*
import estadisticas.*
import comandos.*


class Proyectil{
	
	var property position = null
	var property image = "barril.png" //hay que buscar un Spell que sea redondo, para que no haya que poner uno por direccion
	var velocidad = 50
	const caster = null
	var danio = 0
	
	method solido() = false
	method recibirDanio(dmg) {}
	
	method despawnear(){
		game.removeVisual(self)
	}
	
	method desplazarse(direccion) {
		self.position(direccion.siguiente(self.position()))
	}
	
	method volar() {
		game.onTick(velocidad, "volar", {self.desplazarse(caster.ultimaDireccion())})
	}
	
	method daniar() {
		game.onCollideDo(self, {cosa => self.daniar(cosa)})
	}
	
	method daniar(alguien) {
		alguien.recibirDanio(danio)
		self.despawnear()
	}
	
	
	method cambiarImagen(img) {
		image = "proyectil_" + img.toString() + ".png"
	}
	
	method serInvocado(speed, dmg /*,img*/) {
		velocidad = speed
		danio = dmg
		//self.cambiarImagen(img)
		game.addVisual(self)
		self.volar()
		self.daniar()
	}
}


