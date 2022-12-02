import construccion.*
import wollok.game.*
import seresVivos.*
import recursos.*
import comandos.*
import items.*
import enemigos.*

class Decoracion { 

	var property image
	var property position

	method solido() = true
	
	method serInteractuado(personaje){}
	
	method accionAlSerColisionado(){}
	
	method recibirDanio(dmg){}
}

object mapaActual {
	
	var property mapa
	var property image = "ElegirPersonaje.png"
	const property position = game.at(0,0)
		
	
	method solido() = false
	
	method recibirDanio(dmg) {}

	method inicializarMapa() {
		mapa.setearEsceneario()
	}

	method cambiarMapa(_mapa) {
		
		self.mapa(_mapa)
		self.inicializarMapa()
	}
}

class Escenario {

	const construcciones
	const recursos
	var property positionAlComenzar = game.at(0, 1)
	var property image



	method colocarObjetoSolido(_image, _position) {
		const objetoSolido = new Decoracion(image = _image, position = _position)
		game.addVisual(objetoSolido)

	}

	method colocarLimite(_mapa, mapaLimite, _image, _position) {
		const limite = new LimiteHaciaMapa(image = _image, position = _position, mapa = _mapa, mapaDelQueEsLimite = mapaLimite)
		game.addVisual(limite)
	}
	


	method setearEsceneario() {
		game.clear()
		
		mapaActual.image(self.image())
		game.addVisual(mapaActual)
		game.addVisual(configuracion.heroe())
		self.setearPiso()
		self.setearEnemigos()
		self.setearDecoraciones()
		self.setearLimites()
		self.setearConstrucciones()
		self.setearRecursos()
		configuracion.comandos()
		
	}
	
	method setearEnemigos()
	method setearLimites()
	method setearDecoraciones()
	method setearPiso()
	
	method setearRecursos(){
		recursos.forEach({recurso => game.addVisual(recurso)})
		recursos.forEach({recurso => recurso.verSiFueMinado()})
	}
	
	method setearConstrucciones(){
		construcciones.forEach({ construccion => game.addVisual(construccion)})
	}
	
	method setearEnemigo(position, direccion){
		crear.unEnemigoVertical(6,6)
	}
	
	method colocarHeroeEnEntradaMapa()
	method heroePositionAlComenzar()
	
	method setearLimitesIzquierda(limite){
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 0))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 1))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 2))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 3))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 4))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 5))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 6))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 7))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 8))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 9))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 10))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(-1, 11))
	}
	
	method setearLimitesDerecha(limite){
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 0))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 1))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 2))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 3))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 4))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 5))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 6))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 7))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 8))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 9))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 10))
		self.colocarLimite(self, limite, "Transparente32Bits.png", game.at(15, 11))
	}
	

	
	
}

class LimiteHaciaMapa inherits Decoracion (image = "Transparente32Bits") {

	const property mapaDelQueEsLimite
	const property mapa

	method cambiarMapa(_mapa) {

		mapaActual.cambiarMapa(_mapa)
	}
	
	override method recibirDanio(dmg) {}

	override method accionAlSerColisionado() {
		mapaDelQueEsLimite.colocarHeroeEnEntradaMapa()
		self.cambiarMapa(mapaDelQueEsLimite)
	}

}



//========== Explanada
object explanada inherits Escenario ( construcciones = #{ construccionBanco, construccionMercado, construccionArmadura, construccionMagia }, image = "Explanada.png", recursos = #{}) {

	
	override method setearEnemigos(){}
	
	override method setearDecoraciones() {
		// Banderas al lado de armaduras
		self.colocarObjetoSolido("Bandera.png", game.at(11, 7))
		self.colocarObjetoSolido("Bandera.png", game.at(13, 7))
			// Banderas al lado de magia
		self.colocarObjetoSolido("Bandera.png", game.at(10, 8))
		self.colocarObjetoSolido("Bandera.png", game.at(8, 8))
		self.colocarObjetoSolido("Fuente.png", game.at(5, 6))
		self.colocarObjetoSolido("Arbusto.png", game.at(6, 6))
		self.colocarObjetoSolido("Arbusto.png", game.at(4, 6))
			// Decoracion al lado de Mercado
		self.colocarObjetoSolido("Arbusto.png", game.at(3, 2))
		self.colocarObjetoSolido("Arbusto.png", game.at(0, 2))
		self.colocarObjetoSolido("EscaparateTienda.png", game.at(2, 2))
		self.colocarObjetoSolido("Barril.png", game.at(0, 1))
	
	}
	
	override method setearPiso(){
		
	}

	override method setearLimites() {
		self.setearLimitesDerecha(explanada2)
	}

	override method setearRecursos() {
	}

	override method colocarHeroeEnEntradaMapa(){
		configuracion.heroe().position( self.heroePositionAlComenzar()	)
	}
	
	override method heroePositionAlComenzar(){
		if (!configuracion.juegoIniciado()){
			return game.at(5,5)
		}
		else{
			return 	game.at(14,configuracion.heroe().position().y())
		}
	}
}



//========== Explanada2
object explanada2 inherits Escenario (construcciones = #{}, image = "Explanada2.png", recursos = #{arbol1, arbol2, arbol3, piedra1, piedra2, piedra3, cofre1}) {

	
	override method setearPiso(){
			// Seteo Mar
		self.colocarObjetoSolido("Mar.png", game.at(1, 0))
		self.colocarObjetoSolido("Mar.png", game.at(2, 0))
		self.colocarObjetoSolido("Mar.png", game.at(3, 0))
		self.colocarObjetoSolido("Mar.png", game.at(2, 1))
		self.colocarObjetoSolido("Mar.png", game.at(2, 2))
		self.colocarObjetoSolido("Mar.png", game.at(3, 1))
		self.colocarObjetoSolido("Mar.png", game.at(3, 2))
		self.colocarObjetoSolido("Mar.png", game.at(2, 3))
		self.colocarObjetoSolido("Mar.png", game.at(3, 3))
		self.colocarObjetoSolido("Mar.png", game.at(4, 3))
		self.colocarObjetoSolido("Mar.png", game.at(5, 3))
		self.colocarObjetoSolido("Mar.png", game.at(6, 3))
		self.colocarObjetoSolido("Mar.png", game.at(7, 3))
		self.colocarObjetoSolido("Mar.png", game.at(10, 3))
		self.colocarObjetoSolido("Mar.png", game.at(11, 3))
		self.colocarObjetoSolido("Mar.png", game.at(12, 3))
		self.colocarObjetoSolido("Mar.png", game.at(12, 2))
		self.colocarObjetoSolido("Mar.png", game.at(12, 1))
		self.colocarObjetoSolido("Mar.png", game.at(13, 1))
		self.colocarObjetoSolido("Mar.png", game.at(13, 0))
			// seteo montaña comienzo
		self.colocarObjetoSolido("Elevacion.png", game.at(4, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(5, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(6, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(7, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(8, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(9, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(10, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(11, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(12, 9))
		
		// seteo decoracionPlantaSolida
		
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(4, 2))
	}
	

	override method setearEnemigos(){
		crear.unEnemigoHorizontal(7,2)
		crear.unEnemigoHorizontal(6,6)
		crear.unEnemigoVertical(13,8)
	}
	
	override method setearDecoraciones() {
		
		// vallas
		self.colocarObjetoSolido("Valla.png", game.at(1, 9))
		self.colocarObjetoSolido("Valla.png", game.at(2, 9))
		// lapidas
		self.colocarObjetoSolido("Lapida.png", game.at(7, 0))
		self.colocarObjetoSolido("Lapida.png", game.at(8, 0))
		self.colocarObjetoSolido("Lapida.png", game.at(10, 0))
	}

	override method setearLimites() {
		
		self.setearLimitesDerecha(explanada3)
		self.setearLimitesIzquierda(explanada)
		
	}

	override method colocarHeroeEnEntradaMapa(){
		configuracion.heroe().position(self.heroePositionAlComenzar())
	}
	
	override method heroePositionAlComenzar(){
		if ((mapaActual.mapa() == explanada)){ 
			return game.at(-1, configuracion.heroe().position().y())
		}
		else{
			return game.at(14, configuracion.heroe().position().y())
		}
	}
}



//========== Explanada3
object explanada3 inherits Escenario ( construcciones = #{ }, image = "Explanada3.png", recursos = #{arbol4, arbol5, arbol6, piedra4, piedra5, piedra6, cofre2}) {
	
	override method setearPiso(){
		
		// seteo elevacion
		self.colocarObjetoSolido("Elevacion.png", game.at(5, 3))
		self.colocarObjetoSolido("Elevacion.png", game.at(7, 3))
		
		self.colocarObjetoSolido("AntorchaTienda1.png", game.at(5, 5))
		self.colocarObjetoSolido("AntorchaTienda1.png", game.at(7, 5))
		self.colocarObjetoSolido("Elevacion.png", game.at(4, 5))
		self.colocarObjetoSolido("Elevacion.png", game.at(8, 5))
		
		self.colocarObjetoSolido("Elevacion.png", game.at(3, 6))
		self.colocarObjetoSolido("Elevacion.png", game.at(9, 6))
		
		self.colocarObjetoSolido("Elevacion.png", game.at(3, 7))
		self.colocarObjetoSolido("Elevacion.png", game.at(10, 7))
		
		self.colocarObjetoSolido("Elevacion.png", game.at(2, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(10, 8))
		
		self.colocarObjetoSolido("Elevacion.png", game.at(1, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(11, 9))
		
		// seteo agua
		
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(5, 4))
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(7, 4))
		
		// seteo antorchas
		self.colocarObjetoSolido("AntorchaTienda1.png", game.at(7, 9))
		self.colocarObjetoSolido("AntorchaTienda1.png", game.at(5, 9))
		
		// seteo estandartes
		self.colocarObjetoSolido("Bandera.png", game.at(4, 3))
		self.colocarObjetoSolido("Bandera.png", game.at(8, 3))
		
	
	}
	
	override method setearEnemigos(){
		crear.unEnemigoHorizontal(3,1)
		crear.unEnemigoHorizontal(4,6)
		crear.unEnemigoVertical(14,3)
		crear.unEnemigoVertical(5,7)
	}
	
	
	
	override method setearLimites(){
		self.setearLimitesIzquierda(explanada2)
		self.colocarLimite(self, cueva, "Transparente32Bits.png", game.at(6, 9))
	}
	
	override method setearDecoraciones(){
		
	}
	
	override method colocarHeroeEnEntradaMapa(){
		configuracion.heroe().position(self.heroePositionAlComenzar())
	}
	
	override method heroePositionAlComenzar(){
		if ((mapaActual.mapa() == explanada2)){ 
			return game.at(0, configuracion.heroe().position().y())
		}
		else{
			return game.at(6, 8)
		}
	}
}



//========== CUEVA
object cueva inherits Escenario ( construcciones = #{ }, image = "Cueva.png", recursos = #{cofre3, cofre4, cofre5}) {
	
	override method setearPiso(){
		
		//seteo mar
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(4, 0))
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(3, 1))
		self.colocarObjetoSolido("AguaCueva.png", game.at(2, 2))
		self.colocarObjetoSolido("AguaCueva.png", game.at(1, 2))	
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(0, 3))
		
		
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(10, 0))	
		self.colocarObjetoSolido("AguaCueva.png", game.at(11, 0))
		self.colocarObjetoSolido("AguaCueva.png", game.at(12, 1))	
		self.colocarObjetoSolido("Transparente32Bits.png", game.at(12, 2))
		
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(13, 3))
		self.colocarObjetoSolido("DecoracionMapaPasto.png", game.at(14, 3))		
		
				
		// seteo elevaciones
		
		self.colocarObjetoSolido("Elevacion.png", game.at(0, 6))
		self.colocarObjetoSolido("Elevacion.png", game.at(0, 7))
		self.colocarObjetoSolido("Elevacion.png", game.at(1, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(2, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(3, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(4, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(5, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(6, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(7, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(8, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(9, 7))
		self.colocarObjetoSolido("Elevacion.png", game.at(10, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(11, 9))
		self.colocarObjetoSolido("Elevacion.png", game.at(12, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(13, 8))
		self.colocarObjetoSolido("Elevacion.png", game.at(14, 7))
		self.colocarObjetoSolido("Elevacion.png", game.at(14, 6))
		
		self.colocarObjetoSolido("Elevacion.png", game.at(4, 6))
		
	}
	
	override method setearEnemigos(){
		crear.unBoss()
		crear.unEnemigoHorizontal(6,4)
		crear.unEnemigoHorizontal(4,4)
		crear.unEnemigoVertical(13,6)
		crear.unEnemigoVertical(5,7)
	}
	
	
	override method setearLimites(){
		self.colocarLimite(self, explanada3, "Transparente32Bits.png", game.at(5, -1))
		self.colocarLimite(self, explanada3, "Transparente32Bits.png", game.at(6, -1))
		self.colocarLimite(self, explanada3, "Transparente32Bits.png", game.at(7, -1))
		self.colocarLimite(self, explanada3, "Transparente32Bits.png", game.at(8, -1))
		self.colocarLimite(self, explanada3, "Transparente32Bits.png", game.at(9, -1))
		
	
	}
	
	override method setearDecoraciones(){
		
	}
	
	override method colocarHeroeEnEntradaMapa(){
		configuracion.heroe().position(self.heroePositionAlComenzar())
	}
	
	override method heroePositionAlComenzar(){
		return game.at(7, 0)
	}
	
}

object finDeLaPartida inherits Escenario ( construcciones = #{ }, image = "FinDeLaPartida.png", recursos = #{}) {
	
	
	override method setearEsceneario() {
		game.clear()
		mapaActual.image(self.image())
	}
	
	override method setearPiso(){}
	
	override method setearEnemigos(){}
	
	override method setearRecursos(){}
	
	override method setearLimites(){}
	
	override method setearDecoraciones(){}
	
	override method colocarHeroeEnEntradaMapa(){}
	
	override method heroePositionAlComenzar(){}
	
}
