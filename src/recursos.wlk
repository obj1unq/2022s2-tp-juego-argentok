import seresVivos.*
import wollok.game.*


class Recurso
{
	var property position
	var vida
	
	method solido(){
		return true
	}

	
	method image()
	{
		return vida.nombreimg()
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


class Piedra inherits Recurso
{
	
	
	
	
	
}

object piedraVida1
{
	
	const property nombreimg = "PiedraVida1.png"
	
}

object piedraVida2
{
	const property nombreimg = "PiedraVida2.png"
}


object piedraVida3
{
	const property nombreimg = "PiedraVida3.png"
}

class Arbol inherits Recurso
{
	
	//vida =	 vida1
	
	method vida()
	{
		return vida.nombreimg()
	}
	
	
	
}

object arbolVida0
{
	
	const property nombreimg = "ArbolVida0.png"
	
}

object arbolVida1
{
	const property nombreimg = "ArbolVida1.png"
}




