import seresVivos.*
import wollok.game.*


class Recurso
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

	method serInteractuado(personaje){
		// if personaje tiene picacha, else game.say("te falta picacha maestroo")
		self.reducirVida()
	}
	
	
	
	method reducirVida(){
		vida -= 1
		if (vida == 0 ){
			game.say(self,"obtuviste 1 recurso")
			fueMinado = true
			game.removeVisual(self)
		}
		
	}
	
	method verSiFueMinado(){
		if (fueMinado){
			game.removeVisual(self)
		}
	}


}


class Piedra inherits Recurso (vida = 3)
{
	method image(){
		return "PiedraVida" + vida + ".png"
	}
	
	
	
	override method reducirVida(){
		
		super()
		
		
	}
	
	
	
}



class Arbol inherits Recurso (vida = 2)
{
	
	method image(){
		return "ArbolVida" + vida + ".png"
	}
	
	
	override method reducirVida(){
		
		super()
		
	}
	
	
}

// Vuelvo objetos los diferentes piedras y arboles porque necesito que sepan si fueron destruidos, de otra forma cada vez que los instancios al cargar un mapa pierden el valor correspondiente

object arbol1 inherits Arbol(position = game.at(8, 8)){
	
} 

object arbol2 inherits Arbol(position = game.at(3, 9)){
	
} 

object arbol3 inherits Arbol(position = game.at(4, 2)){
	
} 

object arbol4 inherits Arbol(position = game.at(13, 6)){
	
} 

object arbol5 inherits Arbol(position = game.at(10, 1)){
	
} 

object arbol6 inherits Arbol(position = game.at(3, 5)){
	
} 



		



