
import wollok.game.*
import seresVivos.*


class Construccion inherits Solido {

	const property baul = {}

	method serUtilizado()
	
}

object casaDePesca inherits Construccion{
	
	const property image = "casaDePesca.png"
	const property position = game.at(15, 6)   
	
	
	method serUtilizado()
	{
		
	}
}

object casaDeArmas inherits Construccion{
	
	const property image = "casaDeArmas.png"
	const property position = game.at(17, 4)   
	
	method serUtilizado()
	{
		
	}
}

object casaDeHero inherits Construccion{
	
	const property image = "casaDeHero.png"
	const property position = game.at(2, 6)   
	
	method serUtilizado()
	{
		
	}
}



object casaDeMago inherits Construccion{
	
	const property image = "casaDeMago.png"
	const property position = game.at(1, -1)   
	
	method serUtilizado()
	{
		
	}
}