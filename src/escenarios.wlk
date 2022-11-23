import construccion.*
import wollok.game.*
import seresVivos.*
import recursos.*



object mapaActual{
	
	var property mapa
	
	method inicializarMapa(){
		mapa.setearEsceneario()
	}
	
	method cambiarMapa(_mapa){
		
		
		self.mapa(_mapa)
		self.inicializarMapa()
		
		//self.setearMapa(mapa)
	}
}


class Escenario{
	
	const construcciones
	const decoraciones
	const enemigos
	const recursos
	
	//const property decoraciones
	var property image
	var property heroPrimeroPosicion
	
	/*falta const de escenario, deco, recu y limi */
	 // esto se reutiliza, probablemente pueda definir el metodo aca
	method setearDecoraciones()
	method setearLimites()
	method setearRecursos()
	
	method colocarSolido(_image, _position){
		const solido = new Solido(image = _image, position = _position)
		game.addVisual(solido)
	}
	
	method colocarLimite(_mapa, mapaLimite, _image, _position){
		// revisar si podria reutilizar colocar solido, creo que no
		// Revisar si realmente los parametors mapaDelQUesLimtie y mapa se necesitan ambos
		
		const limite = new limiteHaciaMapa(image = _image, position = _position, mapa = _mapa, mapaDelQueEsLimite = mapaLimite) 
		game.addVisual(limite)
	}
	
 
	
	method setearEsceneario(){
		game.clear()
		self.setearRecursos()
		self.setearDecoraciones()
		self.setearLimites()
		self.setearRecursos()
	}
	
	
	 
}

class limiteHaciaMapa{
	
	// Revisar si realmente los parametors mapaDelQUesLimtie y mapa se necesitan ambos
	
	
	const property mapaDelQueEsLimite
	const image = "Transparente32Bits"
	const property position
	const property mapa
	
	
	method cambiarMapa(_mapa){
		
		mapaActual.cambiarMapa(_mapa)
	
	
	}
	
	method accionAlSerColisionado(){
		self.cambiarMapa(mapaDelQueEsLimite)
	}
	
	
	
}


object explanada inherits Escenario (construcciones = #{construccionBanco, construccionMercado, construccionArmadura , construccionMagia}, image = "Explanada.png", heroPrimeroPosicion = game.at(2,3), enemigos = #{}, decoraciones= #{}, recursos =  #{}){
	
	
	
	override method setearEsceneario(){
		game.boardGround(self.image())
		construcciones.forEach({construccion => game.addVisual(construccion)}) 
		self.setearDecoraciones()
		self.setearLimites()
		self.setearRecursos()
		
		
	}
	
	override method setearDecoraciones(){
	
		// Banderas al lado de armaduras
		
		self.colocarSolido("Bandera.png", game.at(11,7))
		self.colocarSolido("Bandera.png", game.at(13,7))
		
		// Banderas al lado de magia
		self.colocarSolido("Bandera.png", game.at(10,8))
		self.colocarSolido("Bandera.png", game.at(8,8))
		
		
		self.colocarSolido("Fuente.png", game.at(5,6))
		self.colocarSolido("Arbusto.png", game.at(6,6))
		self.colocarSolido("Arbusto.png", game.at(4,6))
		
		
		// Decoracion al lado de Mercado
		self.colocarSolido("Arbusto.png", game.at(3,2))
		self.colocarSolido("Arbusto.png", game.at(0,2))
		self.colocarSolido("EscaparateTienda.png", game.at(2,2))
		self.colocarSolido("Barril.png", game.at(0,1))
		
		
		
		
		
	}
	
	override method setearLimites(){
		
		// hacer bucle que vaya creando limites y sume uno a la variable 
		
		/* 
		var contador
		while (contador /= 10){
			const limite1 = new limiteHaciaMapa(mapaDelQueEsLimite = explanada2, position = game.at(14,0) ) // OJO EL 10 DEL GAME.AT ESA HARCODEADO R E V I S A R
			contador =+ 1
		}
		
		*/
		
		//(_mapa, mapaLimite, _image, _position) 
		
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,0))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,1))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,2))
		self.colocarLimite(self, explanada2, "Transparente.png", game.at(15,3))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,4))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,5))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,6))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,7))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,8))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,9))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,10))
		self.colocarLimite(self, explanada2,"Transparente.png", game.at(15,11))
		
	}
	
	override method setearRecursos(){
		
		
		
	}
	
	
	
}

object explanada2 inherits Escenario (construcciones = #{}, image = "Explanada2.png", heroPrimeroPosicion = game.at(2,3), enemigos = #{}, decoraciones= #{}, recursos =  #{}){
		
	override method setearEsceneario(){
		
		super()
		game.boardGround("Explanada2.png")
		
		
		
	}
	
	override method setearDecoraciones(){
		
		
		
		
	}
	
	override method setearLimites(){
		

		
	}
	
	override method setearRecursos(){
		
		const arbol1 = new Arbol(vida = arbolVida1)
		game.addVisual(arbol1)
	}
		
		
		
}



