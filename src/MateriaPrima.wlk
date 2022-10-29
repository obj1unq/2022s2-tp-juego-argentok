import wollok.game.*


class MateriaPrima 
{
	method solido()
	{
		return true
	}
	
}

class Roca inherits MateriaPrima
{
	var image
	var property position
	
	var vida = 3

	
	method image()
	{
		// cuando llega a 0 pone una imagen que se llama piedra0png que seria una vacia (Esto es correcto)
		return "piedra" + vida + ".png" 
	}
	
	method recibirDanio(numero)
	{
		self.validarRecibirDanio()
		
		// atacar con pico 
		
		vida -= 1
		
		if (self.estaRota())
		{
			game.removeVisual(self) 
			const piedraSpawn = new Piedra(position = self.position()) // esto podria hacerlo utilizando un metodo property
			
		}
	}
	
	method validarRecibirDanio()
	{
	 	
	}
	
	
	
	method estaRota()
	{
		return(vida == 0)
	}
}


class Piedra
{
	var position
	const property image = "piedra.png"
	
	
	method position()
	{
		return position
	}
	
	
		
}

