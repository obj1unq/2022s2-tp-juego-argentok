
import wollok.game.*
import seresVivos.*
import escenarios.*


class Construccion {

	const property baul = {}
	const image = null
	const position = null
	method serUtilizado()
	method validarSerUtilizado()
	method solido() = true
}



object construccionBanco inherits Construccion (image = "Banco.png", position = game.at(2,8)){
	
	// Esto deberia de estar en clase construccion e invocarlo con un new supongo
	
	
	override method serUtilizado(){
		
	}
	
	override method validarSerUtilizado(){
		
	
	}
	
	method accionAlSerColisionado(){
		mapaActual.cambiarMapa(construccionBancoInterior)
	}
	
	
	
}


object construccionMercado inherits Construccion (image = "Mercado.png", position = game.at(1,2)){
	
	
	override method serUtilizado(){
		
	}
	
	override method validarSerUtilizado(){
		
	}
	
	
}



object construccionMagia inherits Construccion (image = "Magia.png", position = game.at(9,8)) {
	

	override method serUtilizado(){
		
	}
	
	override method validarSerUtilizado(){
		
	}
}


object construccionArmadura inherits Construccion (image = "Armaduras.png", position = game.at(12,7)){

	
	override method serUtilizado(){
		
	}
	
	override method validarSerUtilizado(){
		
	}
}


