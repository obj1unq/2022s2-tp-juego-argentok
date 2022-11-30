import wollok.game.*
import items.*
import seresVivos.*
import escenarios.*
import estadisticas.*


class Proyectil{
	
	var property position = null
	var property image = "barril.png" //hay que buscar un Spell que sea redondo, para que no haya que poner uno por direccion
	const velocidad = 125
	const caster = null
	
	method solido() = false
	
	method danio() {
		return 10 + caster.danio()
	}
	
	
}


