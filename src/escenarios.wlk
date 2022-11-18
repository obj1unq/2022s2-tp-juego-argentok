import construccion.*
import wollok.game.*

object mapaActual{
	
	var property mapa
	
	method inicializarMapa(){
		mapa.setearEsceneario()
	}
}


class Escenario{
	
	const construcciones
	const property image
	
	method setearEsceneario()
	
}


object explanada inherits Escenario (construcciones = #{construccionBanco, construccionMercado, construccionArmadura, construccionMagia}, image = "Explanada.png"){
	
	
	
	override method setearEsceneario(){
		game.boardGround(self.image())
		construcciones.forEach({construccion => game.addVisual(construccion)}) 
	}
	
	
	
}
