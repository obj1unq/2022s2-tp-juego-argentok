class Estadistica {
	
	var valor = 0
	
	method valor() = valor
		
	method subirStat(cuanto) {
		valor += cuanto
	}
}

object fuerza inherits Estadistica {}
object agilidad inherits Estadistica {}
object inteligencia inherits Estadistica {}
object salud inherits Estadistica {}
object manaMax inherits Estadistica {}