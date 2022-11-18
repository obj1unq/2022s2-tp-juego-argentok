import construccion.*
import wollok.game.*
import seresVivos.*



object mapaActual{
	
	var property mapa
	
	method inicializarMapa(){
		mapa.setearEsceneario()
	}
	
	method cambiarMapa(_mapa){
		// segun con lo que colisionas cambias de mapa? 
		
		mapa =  _mapa // colision.mapa() tambien podria ser con un metodo polimorfico que asumo deberian poder usar todas las cosas con las que se puede colisionar?
		self.inicializarMapa()
	}
}


class Escenario{
	
	const construcciones
	//const property decoraciones
	const property image
	
	method setearEsceneario()
	method setearDecoraciones()
	method setearLimites()
	method setearRecursos()
	
	method colocarSolido(_image, _position)
	{
		const solido = new Solido(image = _image, position = _position)
		game.addVisual(solido)
	}
	
}

// ESTE OBJETO LO USARIA PARA CREAR LIMITES DE MAPA

class limiteHaciaMapa{
	
	const property mapaDelQueEsLimite
	const image = "Transparente32Bits"
	const property position
	
	
}

object limiteHaciaExplanada2{

	
	method nuevo(_position, limiteHacia)
	{
			const limite = new limiteHaciaMapa(mapaDelQueEsLimite = limiteHacia, position = _position )
	}
}

object explanada inherits Escenario (construcciones = #{construccionBanco, construccionMercado, construccionArmadura, construccionMagia}, image = "Explanada.png"){
	
	
	
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
		
	
	
	
	}
	
	override method setearRecursos(){
		
		
		
	}
	
	
	
}

object explanada2 inherits Escenario (construcciones = #{}, image = "Explanada2.png"){
		
	override method setearEsceneario(){
		game.boardGround(self.image())
		construcciones.forEach({construccion => game.addVisual(construccion)}) 
		self.setearDecoraciones()
		self.setearLimites()
		self.setearRecursos()
		
		
	}
	
	override method setearDecoraciones(){
		
		
		
		
	}
	
	override method setearLimites(){
		

		
	}
	
	override method setearRecursos(){
		
	}
		
		
		
}



