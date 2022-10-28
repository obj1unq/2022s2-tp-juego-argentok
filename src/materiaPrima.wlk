import seresVivos.*
import wollok.game.*


class MateriaPrima inherits Solido
{
	
	var vida
	
	method image()
	{
		
	}
	
	/* 
	
	No es responsabilidad de piedra romperse 
	 
	method Romperse()
	{
		self.validarRomperse()
		
		
	}
	
	method validarRomperse()
	{
		if (game.colliders(self).isEmpty())
		{
			self.error("no hay qu")
		}
	}
	
	
	*/
}


class Piedra inherits MateriaPrima
{
	
	//vida = vida1
	
	method vida()
	{
		return vida.nombreimg()
	}
	
	
	
}

object vida1
{
	
	const property nombreimg = "piedraVida1"
	
}

object vida2
{
	const property nombreimg = "piedraVida2"
}


object vida3
{
	const property nombreimg = "piedraVida3"
}