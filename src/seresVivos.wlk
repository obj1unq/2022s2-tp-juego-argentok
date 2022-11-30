import wollok.game.*
import items.*
import comandos.*
import escenarios.*
import estadisticas.*

class Mortal {
	

	var property vida = 0
	var ultimaDireccion = null
	var property position = null
	var property image = null
	
	method solido() = true
	
	method puedoPasar(direccion) {
		return self.noHaySolidosAdelante(direccion) and self.validarEjeX(direccion) and self.validarEjeY(direccion)
	}

	method noHaySolidosAdelante(direccion) {
		return self.losSolidos(game.getObjectsIn(direccion.siguiente(self.position()))).isEmpty()
	}
	
	method losSolidos(lista) {
		return lista.filter({cosa => cosa.solido()})
	}
	

	// los números finales a los siguientes metodos deben ser cambiados dependiendo el tamaño que tenga el mapa 
	method validarEjeX(direccion) {
		return direccion.siguiente(position).x().between(0, 14)
	}

	method validarEjeY(direccion) {
		return direccion.siguiente(position).y().between(0, 9)		
	}
	
	method accionAlSerColisionado(){
		// no lo puedo hacer abstracto porque instancio varias veces a solido
	}
	
	
	method morir() {
		if (vida <= 0) {
			self.despawnear()	
			self.entregarExp()
			self.gameOver()	
		}
	}

	method despawnear() {
		game.removeVisual(self)
	}
	
	method gameOver()
	
	method entregarExp()
	
	method recibirDanio(dmg) {
		vida -= dmg
	}

	method atacar()

	method danio()
	
	method estaEnfrente() {
		return game.getObjectsIn(ultimaDireccion.siguiente(self.position()))
	}

	method mover(direccion)
	method ultimaDireccion(direccion) {
		ultimaDireccion = direccion
	} 

}

class Heroe inherits Mortal {

	
	// REVISAR, esto deberai de ser un objeto para que pueda mantener su informacion independientemente del mapa en el que esta.
	// Tampoco tiene sentido tener que instanciarlo varias veces 
	
	//var property position = game.center()
 	//var property image = "hero.png"
	
	
	const inventario = []
	var armaEquipada = null
	var experiencia = 0
    var property oro = 0
	var nivel = 1
	const stats = [fuerza, agilidad, inteligencia, salud, manaMax]
  
	override method mover(direccion) {
		if (self.puedoPasar(direccion)) {
			position = direccion.siguiente(self.position())
		} 
		else {
			self.estaEnfrente().forEach({objeto => objeto.accionAlSerColisionado()})
		}
		self.ultimaDireccion(direccion)
	}
	
	method arribaDe() {
		return game.getObjectsIn(self.position())
	}
	
	method experiencia() = experiencia
	
	method nivel() = nivel
	
	method ganarExp(cantidad) {
		experiencia += cantidad
		self.subirNivel()
	}
	
	method subirNivel() {
		if (self.expNecesariaPorNivel() <= experiencia) {
			nivel += 1
			self.subirStats()
			game.say(self, "Subi de nivel")
			
		}
	}
	
	method decirStats() {
		return "Fue=" + fuerza.valor().toString() +
			   "     Agi=" + agilidad.valor().toString() + 
			   "  Int=" + inteligencia.valor().toString()
	}
	
	method decirVida() {
		return "Vida      " + vida.toString() + "/" + salud.valor().toString()
	}
	
	method decirNivelYExp() {
		return "Nivel=" + nivel.toString() + "  XP=" + experiencia.toString() + "/" + self.expNecesariaPorNivel().toString()
	}
	
	method decirMana()
	
	method subirStats()
	
	method expNecesariaPorNivel() {
		return (100 - nivel) * nivel * nivel
	}
	
	method equiparArma(arma) {
		armaEquipada = arma 
	}

	/* 
	method interactuar(cosa) {
		cosa.serInteractuado(self)
	}
	*/
	
	/* 
	method interactuarConTodos() {
		self.arribaDe().forEach({cosa => self.interactuar(cosa)})
	}
	*/
	
	
	  
	method interactuar() {
		self.interactuables().forEach({ cosa => cosa.serInteractuado(self)})
	}


	method interactuables() {
		return game.getObjectsIn(self.position().up(1))
	}
	 
	
	
	
	method serInteractuado(alguien){}
	
	method agarrarItem(item) {
		inventario.add(item)
	}
	
	method curarse(cantidad) {
		vida = (vida + cantidad).min(salud.valor())
	}
	 
	method inventario() = inventario
	
	method equiparItem(item) {
	}

	
	override method danio() {
		return armaEquipada.puntosDeDanio() + 10 * self.tipoDeDanio().valor()
	}

	method armadura() {
  	return 5 * agilidad.valor()
	}

	method puntosDeDanioDelArmaActual() {
	//	return self.armaActual().puntosDeDanio() // ARMAACTUAL NO EXISTE
	}

	
	
	method tipoDeDanio()
	
	override method entregarExp() {}
	
	
	override method atacar() {
		//acá va a ir el visual para el sprite de atacar

		if (! self.estaEnfrente().isEmpty()) {
			self.estaEnfrente().first().recibirDanio(self.danio())
		}
	}
		
		//y aca tiene que ir una rama ELSE con el sprite de ataque (si se quiere)


	method ganarOroPorVenta(cantOro){
		oro = self.oro() + cantOro
	}

	method valorDelInventario() {
		return inventario.sum({ item => item.valor() })
	}

	method vaciarInventario() {
		inventario.clear()
	}

	// metodos para interactuar con las casas
	method poseePiedras() {
		return inventario.contains(piedra)
	}

	method poseeMadera() {
		return inventario.contains(madera)
	}

	method gananciaPorItemsVendidos(_item) {
		return inventario.count({ item => item == _item }) * _item.valor()
	}

	method borrarItems(_item) {
		inventario.removeAllSuchThat({ item => item == _item})
	}

	method dejarItemEnUnaCasa(item, casa) {
		inventario.remove(item)
		casa.depositar(item)
	}

	method agregar(items) {
		inventario.add(items)
	}

	method usarCasaDeMagia(casaDeMagia) {
		game.say(self, "Bienvenido a la Casa de Magias. Elige la opción deseada: 
				1. Comprar un báculo
				2. Mejorar arma
				3. Consultar stock")
	}
	// habilitar botones
	method usarCasaDeArmaduras(casaDeArmadura) {
		game.say(self, "Bienvenido a la Casa de Armaduras. Elige la opción deseada: 
				1. Comprar espada
				2. Mejorar arma
				3. Consultar stock")
	}
	
	method usarBanco(banco) {
		// habilitar botones
		game.say(self, "Bienvenido al Banco Central. Elige la opción deseada: 
				1. Depositar oro
				2. Retirar oro
				3. Consultar oro")
	}


	method usarMercado(mercado) {
		game.say(self, "Bienvenido al ArgenMercado.
						1. Vender piedra
						2. Vender madera")
	}

	// METODOS DE CAMBIO DE MAPA
	
	// TODAVIA NO SE COMO HACER PARA COMPARAR SI ESTA CON UN LIMITE, el problema viene porque quiero comparar una instancia a la lista de objetos posibles a colisionar
	
	/* 
	
	method cambioDeMapa(direccion){
		if (game.getObjectsIn(direccion.siguiente(self.position())) == #{}){
			
		
	}
	*/
	
	
	override method gameOver(){
		//aca tiene que ir la pantalla de Game Over
	}
  
  
	/* 

	method interactuables() {
		return game.getObjectsIn(self.position().up(1))
	}
	 
	*/
	
	

	method comprar() {
		self.interactuables().forEach({ cosa => cosa.comprar(self)})
	}

	method vender() {
		self.interactuables().forEach({ cosa => cosa.vender(self)})
	}

	method consultar() {
		self.interactuables().forEach({ cosa => cosa.consultar(self)})
	}
}

object mago inherits Heroe {
	var mana = 0
	
	override method tipoDeDanio() {
		return stats.get(3)
	}
	
	override method subirStats() {
		 agilidad.subirStat(5)
		 salud.subirStat(10)
		 inteligencia.subirStat(5)
		 manaMax.subirStat(15)
	}
	
	override method decirMana() {
		return "Mana      " + mana.toString() + "/" + manaMax.valor().toString()
	}
	
	method regenerarMana(cantidad) {
		mana = (mana+ cantidad).min(manaMax.valor())
	}
	
	override method mover(direccion) {
		super(direccion)
		image = "Mago_" + ultimaDireccion.toString() + ".png"
	}
}

object guerrero inherits Heroe {
	
	override method tipoDeDanio() {
		return stats.first()	
	}
	
	override method subirStats() {
		 fuerza.subirStat(5)
		 salud.subirStat(25)
		 agilidad.subirStat(5)
	}
	
	override method decirMana() {
		return "Los Guerreros no usamos Mana pa"
	}
	
	override method mover(direccion) {
		super(direccion)
		image = "Guerrero_" + ultimaDireccion.toString() + ".png"
	}

	
}

class Enemigo inherits Mortal {

	const expEntregadaBase = 50
	
	const heroe = null 
	
	override method recibirDanio(dmg) {
		super(dmg)
		self.morir() 
	}
	
	override method entregarExp() {
		heroe.ganarExp(self.expEntregada()) 
	}
	
	method expEntregada() {
		return (expEntregadaBase / heroe.nivel()).roundUp() 
	}
	
	override method gameOver(){}
	
	method heroe(_heroe) = _heroe
	
	override method mover(asd){}
	override method atacar(){}
	override method danio() {}
}
