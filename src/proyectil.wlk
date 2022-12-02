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
	var danio = 0
	var property direccion = null
	
	method solido() = false
	method recibirDanio(dmg) {}
	
	method despawnear(){
		game.removeTickEvent("volar")		
		game.removeVisual(self)
	}
	
	method despawnearSi(){
		if(!self.estaAdentro()) {
			self.despawnear()
		}
	}
	
	method estaAdentro(){
		return ejes.validarX(direccion, position, -1, 15 ) and ejes.validarY(direccion, position, -1, 10) 
	}
	
	method desplazarse(_direccion) {
		self.position(_direccion.siguiente(self.position()))
		self.despawnearSi()
	}
	
	method volar() {
		game.onTick(velocidad, "volar", {self.desplazarse(direccion)})
	}
	
	method daniar() {
		game.onCollideDo(self, {cosa => self.daniar(cosa)})
	}
	
	method daniar(alguien) {
		alguien.recibirDanio(danio)
		self.despawnear()
	}
	
	
	method cambiarImagen(img) {
		image = "proyectil_" + img + ".png"
	}
	
	method serInvocado(speed, dmg ,img, dir) {
		velocidad = speed
		danio = dmg
		direccion = dir
		self.cambiarImagen(img)
		game.addVisual(self)
		self.volar()
		self.daniar()
	}
}


