import construccion.*
import wollok.game.*
import seresVivos.*
import recursos.*
import comandos.*



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
	var property positionAlComenzar = game.at(0,1)
	
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
		const tito = new Heroe(image = "MagoSur.png", position = game.at(0,0), armaEquipada = tester.espada())
		game.addVisual(tito)
		configuracion.comandos(tito)
		
		//
		

		game.boardGround("Explanada2.png")
		
		
		// Seteo Mar
		self.colocarSolido("Mar.png", game.at(2,0))
		self.colocarSolido("Mar.png", game.at(3,0))
		self.colocarSolido("Mar.png", game.at(4,0))
		self.colocarSolido("Mar.png", game.at(3,1))
		self.colocarSolido("Mar.png", game.at(4,1))
		self.colocarSolido("Mar.png", game.at(3,2))
		self.colocarSolido("Mar.png", game.at(4,2))
		self.colocarSolido("Mar.png", game.at(3,3))
		self.colocarSolido("Mar.png", game.at(4,3))
		self.colocarSolido("Mar.png", game.at(5,3))
		self.colocarSolido("Mar.png", game.at(6,3))
		self.colocarSolido("Mar.png", game.at(7,3))
		self.colocarSolido("Mar.png", game.at(10,3))
		self.colocarSolido("Mar.png", game.at(11,3))
		self.colocarSolido("Mar.png", game.at(12,3))
		self.colocarSolido("Mar.png", game.at(12,2))
		self.colocarSolido("Mar.png", game.at(12,1))
		self.colocarSolido("Mar.png", game.at(13,1))
		self.colocarSolido("Mar.png", game.at(13,0))
		
		// seteo montaña comienzo
		
		self.colocarSolido("Elevacion.png", game.at(5,9))
		self.colocarSolido("Elevacion.png", game.at(6,8))
		self.colocarSolido("Elevacion.png", game.at(7,8))
		self.colocarSolido("Elevacion.png", game.at(8,9))
		self.colocarSolido("Elevacion.png", game.at(9,9))
		self.colocarSolido("Elevacion.png", game.at(10,9))
		self.colocarSolido("Elevacion.png", game.at(11,9))
		self.colocarSolido("Elevacion.png", game.at(12,8))
		self.colocarSolido("Elevacion.png", game.at(13,9))
		
	}
	
	override method setearDecoraciones(){
		
		
		// vallas
		self.colocarSolido("Valla.png", game.at(1,9))
		self.colocarSolido("Valla.png", game.at(2,9))
		self.colocarSolido("Valla.png", game.at(3,9))
		
		//  lapidas
		
		self.colocarSolido("Lapida.png", game.at(7,0))
		self.colocarSolido("Lapida.png", game.at(8,0))
		self.colocarSolido("Lapida.png", game.at(10,0))
		
		
		
		
	}
	
	override method setearLimites(){
		

		
	}
	
	override method setearRecursos(){
		
		const arbol1 = new Arbol(vida = arbolVida1, position = game.at(8,8))
		game.addVisual(arbol1)
		
		const arbol1 = new Arbol(vida = arbolVida1, position = game.at(5,0))
		game.addVisual(arbol1)
		
		
		const arbol1 = new Arbol(vida = arbolVida1, position = game.at(4,9))
		game.addVisual(arbol1)
		
	
		
	}
		
		
		
}



