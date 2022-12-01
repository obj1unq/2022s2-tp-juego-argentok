import seresVivos.*
import wollok.game.*
import seresVivos.*
import comandos.*
import items.*

class ObjetoQueDaRecursos
{
	var property position
	var vida
	//var property image
	var property fueMinado = false
	
	
	method solido(){
		return true
	}
	
	method accionAlSerColisionado(){
		
	}
	
	method recibirDanio(dmg){
		
	}

	method serInteractuado(personaje){
		// if personaje tiene picacha, else game.say("te falta picacha maestroo")
		self.reducirVida()
	}
	
	
	
	method reducirVida(){
		
		
		self.validarReducirVida()
		vida -= 1
		if (vida == 0 ){
		
			fueMinado = true
			game.removeVisual(self)
			
		}
		
	}
	
	method validarReducirVida(){
		if (vida <= 1){
			self.error("Ya saque todos los recursos posibles de aca")	
		}
		
		
	}
	
	method verSiFueMinado(){
		if (fueMinado){
			game.removeVisual(self)
		}
	}


}


class Piedra inherits ObjetoQueDaRecursos (vida = 3)
{
	method image(){
		return "PiedraVida" + vida + ".png"
	}
	
	
	
	override method reducirVida(){
		
		super()
		game.say(self, "agarre 1 de piedra! vamoo")
		configuracion.heroe().agregar(piedra)
		
	}
	
	
	
}



class Arbol inherits ObjetoQueDaRecursos (vida = 2)
{
	
	method image(){
		return "ArbolVida" + vida + ".png"
	}
	
	
	override method reducirVida(){
		
		super()
		game.say(self, "agarre 1 de madera! vamoo")
		configuracion.heroe().agregar(madera)
		
		
	}
	
	
}

class Cofre inherits ObjetoQueDaRecursos (vida = 2)
{
	method image(){
		return "CofreVida" + vida + ".png"
	}
	override method reducirVida(){
		
		super()
		
	
		game.say(self,"listoo me robe 100 de oro")
		configuracion.heroe().ganarOro(100)
		
	}
	
}



// Vuelvo objetos los diferentes piedras y arboles porque necesito que sepan si fueron destruidos, de otra forma cada vez que los instancios al cargar un mapa pierden el valor correspondiente

object cofre1 inherits Cofre(position = game.at(6, 2)){
	
} 

object cofre2 inherits Cofre(position = game.at(13, 8)){
	
} 

object cofre3 inherits Cofre(position = game.at(7, 8)){
	
} 

object cofre4 inherits Cofre(position = game.at(5, 8)){
	
} 

object cofre5 inherits Cofre(position = game.at(11, 8)){
	
} 


object arbol1 inherits Arbol(position = game.at(8, 8)){
	
} 

object arbol2 inherits Arbol(position = game.at(3, 9)){
	
} 

object arbol3 inherits Arbol(position = game.at(5, 2)){
	
} 

object arbol4 inherits Arbol(position = game.at(12, 6)){
	
} 

object arbol5 inherits Arbol(position = game.at(10, 1)){
	
} 

object arbol6 inherits Arbol(position = game.at(3, 5)){
	
} 


object piedra1 inherits Piedra(position = game.at(4, 1)){
	
} 

object piedra2 inherits Piedra(position = game.at(10, 8)){
	
} 

object piedra3 inherits Piedra(position = game.at(7, 8)){
	
} 

object piedra4 inherits Piedra(position = game.at(13, 3)){
	
} 

object piedra5 inherits Piedra(position = game.at(8, 7)){
	
} 

object piedra6 inherits Piedra(position = game.at(2, 1)){
	
} 





		



