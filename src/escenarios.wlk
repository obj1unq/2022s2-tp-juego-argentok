import construccion.*
import wollok.game.*
import seresVivos.*
import recursos.*
import comandos.*
import items.*
import enemigos.*

class Decoracion { // que realmente no es una decoracion deberia llamarse "objetoSolido"  ES CONVENIENTE POR EJEMPLO QUE LOS LIMITES DE MAPA TAMBIEN HEREDEN DE POR ENDE YO CREO QUE DEBERIA LLAMARSE OBJETO SOLIDO

	var property image
	var property position

	method solido() {
		return true
	}
	
	method accionAlSerColisionado(){
		
	}

}

object mapaActual {
	

	
	var property mapa
	var property image = "ElegirPersonaje.png"
	const property position = game.at(0,0)
		
	
	method solido(){
		return false
	}
	
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
	//const enemigos, no lo hago como una lista porque para eso tengo qeu instanciar en objetos enemigos y es una clase, podria hacerlo en objetos pero no se que tanto sentido tiene
	
	var property positionAlComenzar = game.at(0, 1)
	
	var property image
	//var property heroPrimeroPosicion podria usar un tipo de position



	method colocarObjetoSolido(_image, _position) {
		const objetoSolido = new Decoracion(image = _image, position = _position)
		game.addVisual(objetoSolido)

	}

	method colocarLimite(_mapa, mapaLimite, _image, _position) {
		// revisar si podria reutilizar colocar solido, creo que no
		// Revisar si realmente los parametors mapaDelQUesLimtie y mapa se necesitan ambos
		const limite = new LimiteHaciaMapa(image = _image, position = _position, mapa = _mapa, mapaDelQueEsLimite = mapaLimite)
		game.addVisual(limite)
	}
	


	method setearEsceneario() {
		game.clear()
		
		mapaActual.image(self.image())
		game.addVisual(mapaActual)
		game.addVisual(configuracion.heroe())
		self.setearRecursos()
		self.setearEnemigos()
		self.setearDecoraciones()
		self.setearLimites()
		self.setearConstrucciones()
		configuracion.comandos()
		
	}
	
	method setearEnemigos()
	method setearRecursos()
	method setearLimites()
	method setearDecoraciones()
	
	method setearConstrucciones(){
		construcciones.forEach({ construccion => game.addVisual(construccion)})
	}
	
	method setearEnemigo(position, direccion){
		const malito = new EnemigoHorizontal(image = "EsqueletoSur.png", position = position,vida = 300, sentidoActual = direccion)
		game.addVisual(malito)
		game.onTick(500, "moverse", {malito.moverse()})
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



	// Revisar si realmente los parametors mapaDelQUesLimtie y mapa se necesitan ambos
	const property mapaDelQueEsLimite
	const property mapa

	method cambiarMapa(_mapa) {

		mapaActual.cambiarMapa(_mapa)
	}
	
	method recibirDanio(dmg) {} // RECIBIR DAÑO? POR QUE?

	method accionAlSerColisionado() {
		mapaDelQueEsLimite.colocarHeroeEnEntradaMapa()
		self.cambiarMapa(mapaDelQueEsLimite)
	}

}



//========== Explanada
object explanada inherits Escenario ( construcciones = #{ construccionBanco, construccionMercado, construccionArmadura, construccionMagia }, image = "Explanada.png", recursos = #{}) {

	override method setearEsceneario() {
		super()
		
	}
	
	override method setearEnemigos(){
		
	}
	
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

	override method setearLimites() {
		self.setearLimitesDerecha(explanada2)
	}

	override method setearRecursos() {
	}

	override method colocarHeroeEnEntradaMapa(){
		//configuracion.heroe().position(game.at(configuracion.heroe().position().y(),0) )
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
object explanada2 inherits Escenario (construcciones = #{}, image = "Explanada2.png", recursos = #{}) {

	override method setearEsceneario() {
		super()

		
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

	}

	override method setearEnemigos(){
		self.setearEnemigo(game.at(5,5), derecha)
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

	override method setearRecursos() {
		const arbol1 = new Arbol(vida = arbolVida1, position = game.at(8, 8))
		game.addVisual(arbol1)
		const arbol1 = new Arbol(vida = arbolVida1, position = game.at(5, 0))
		game.addVisual(arbol1)
		const arbol1 = new Arbol(vida = arbolVida1, position = game.at(3, 9))
		game.addVisual(arbol1)
	}

	override method colocarHeroeEnEntradaMapa(){
		configuracion.heroe().position(self.heroePositionAlComenzar())
	}
	
	override method heroePositionAlComenzar(){
		if (mapaActual.mapa() == explanada){
			
			return game.at(-1, configuracion.heroe().position().y())
		}
		else{
			
			return game.at(15, configuracion.heroe().position().y())
		}
		
		
		//configuracion.heroe().opuestoPosition().x(), configuracion.heroe().position().y())
	}
	
	
}



//========== Explanada3
object explanada3 inherits Escenario ( construcciones = #{ }, image = "Explanada3.png", recursos = #{}) {
	
	override method setearEnemigos(){
		
	}
	
	override method setearRecursos(){
		
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
		if (mapaActual.mapa() == explanada2){
			
			return game.at(0, configuracion.heroe().position().y())
		}
		else{
			
			return game.at(6, 8)
		}
	}
	
}



//========== CUEVA
object cueva inherits Escenario ( construcciones = #{ }, image = "Cueva.png", recursos = #{}) {
	
	override method setearEnemigos(){
		
	}
	
	override method setearRecursos(){
		
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
		return game.at(configuracion.heroe().position().x(), 0)
	}
	
}





