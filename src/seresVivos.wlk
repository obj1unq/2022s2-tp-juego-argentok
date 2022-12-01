import wollok.game.*
import items.*
import comandos.*
import escenarios.*
import estadisticas.*

class Mortal {

	var property vida = 0
	var property ultimaDireccion = abajo
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
		return lista.filter({ cosa => cosa.solido() })
	}

	// los números finales a los siguientes metodos deben ser cambiados dependiendo el tamaño que tenga el mapa 
	method validarEjeX(direccion) {
		return direccion.siguiente(position).x().between(0, 14)
	}

	method validarEjeY(direccion) {
		return direccion.siguiente(position).y().between(0, 9)
	}

	method accionAlSerColisionado() {
	// no lo puedo hacer abstracto porque instancio varias veces a solido
	}

	method morir() {
		if (vida <= 0) {
			self.gameOver()
			self.entregarRecompensa()
			self.despawnear()
		}
	}

	method despawnear() {
		game.removeVisual(self)
	}

	method recibirDanio(dmg) {
		vida -= dmg
		self.morir()
	}

	method estaEnfrente() {
		return game.getObjectsIn(self.enFrente())
	}
	
	method enFrente() {
		return ultimaDireccion.siguiente(self.position())
	}

	method mover(direccion)

	method ultimaDireccion(direccion) {
		ultimaDireccion = direccion
	}

	method atacar()

	method gameOver()

	method danio()

	method entregarRecompensa()

}

class Heroe inherits Mortal {

	const inventario = []
	var property armaEquipada = null
	var experiencia = 0
	var property oro = 0
	var nivel = 1
	const stats = [ fuerza, agilidad, inteligencia, salud, manaMax ]
	var defendiendo = false

	method experiencia() = experiencia

	method nivel() = nivel

	method inventario() = inventario

	override method mover(direccion) {
		if (self.puedoPasar(direccion)) {
			position = direccion.siguiente(self.position())
		} else {
			self.estaEnfrente().forEach({ objeto => objeto.accionAlSerColisionado()})
		}
		self.ultimaDireccion(direccion)
		image =  self.cambiarImagen("")
	}

	method arribaDe() {
		return game.getObjectsIn(self.position())
	}

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
		return "Fue=" + fuerza.valor().toString() + "     Agi=" + agilidad.valor().toString() + "  Int=" + inteligencia.valor().toString()
	}

	method decirVida() {
		return "Vida      " + vida.toString() + "/" + salud.valor().toString()
	}

	method decirNivelYExp() {
		return "Nivel=" + nivel.toString() + "  XP=" + experiencia.toString() + "/" + self.expNecesariaPorNivel().toString()
	}
	
	method decirInventario() {
		return "Inventario " + inventario.toString()
		
		// hay que cambiarlo y dejarlo mejor cuando los recursos esten bien definidos
	}
	
	method decirOro() {
		return "Tengo " + oro.toString() + " oro"
	}

	method expNecesariaPorNivel() {
		return (101 - nivel) * nivel * nivel
	}

	method interactuar() {
		self.interactuables().forEach({ cosa => cosa.serInteractuado(self)})
	}

	method interactuables() {
		return game.getObjectsIn(self.position().up(1))
	}

	method serInteractuado(alguien) {
	}

	method curarse(cantidad) {
		vida = (vida + cantidad).min(salud.valor())
	}

	override method danio() {
		return armaEquipada.puntosDeDanio() + 10 * self.tipoDeDanio().valor()
	}

	method armadura() {
		return 5 * agilidad.valor()
	}
	
	override method recibirDanio(danio) {
		if (! defendiendo) {
			super(danio - self.armadura()) 
		}
	}

	method puntosDeDanioDelArmaActual() {
	// return self.armaActual().puntosDeDanio() // ARMAACTUAL NO EXISTE
	}

	method ganarOro(cantidad) {
		oro += cantidad
	}

	method ganarOroPorVenta(cantOro) {
		self.ganarOro(cantOro)
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

	override method gameOver() {
	// aca tiene que ir la pantalla de Game Over
		game.schedule(2500, {game.stop()})
	}

	method comprar() {
		self.interactuables().forEach({ cosa => cosa.comprar(self)})
	}

	method vender() {
		self.interactuables().forEach({ cosa => cosa.vender(self)})
	}

	method consultar() {
		self.interactuables().forEach({ cosa => cosa.consultar(self)})
	}
	
	method cambiarImagen(string) {
		return self.toString() + "_" + ultimaDireccion.toString() + string + ".png" 
	}
	
	method defenderse() {
		sprite.deHeroe(self, 500, self.cambiarImagen("_escudo"), self.cambiarImagen(""))
		defendiendo = true
		game.schedule(500,{defendiendo = false})
	}
	
	method decirMana()

	method tipoDeDanio()
	
	method hechizo()

	method subirStats()
	
	override method entregarRecompensa() {
	}

}

object mago inherits Heroe {

	var mana = 0
	
	var hechizoEnCD = false

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
		mana = (mana + cantidad).min(manaMax.valor())
	}
	
	override method hechizo() {
		self.verificarLanzarHechizo()
		mana -= 20
		hechizoEnCD = true
		game.schedule(5000, {hechizoEnCD = false})	
		
		self.invocarHechizo()
	}
	
	method invocarHechizo() {
		game.say(self, "PEW")
		crear.hechizo(self).serInvocado(75, self.danioDeHechizo())
	}
	override method atacar() {
		crear.hechizo(self).serInvocado(150, self.danio())
	}
	
	method verificarLanzarHechizo() {
		self.verificarTengoMana()
		self.verificarCD()
	}
	
	method verificarTengoMana() {
		if (mana < 20) {
			self.error("No tengo suficiente Mana")
		}
	}
	method verificarCD() {
		if (hechizoEnCD) {
			self.error("El hechizo se esta recargando")
		}
	}
	method danioDeHechizo() {
		return self.danio() * nivel
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
		return "Los Guerreros no necesitamos Mana"
	}
	
	override method hechizo() {
		game.say(self, "Los Guerreros no necesitamos hechizos")
	}
	
	override method atacar() {
		sprite.deHeroe(self, 125, self.cambiarImagen("_espada"), self.cambiarImagen(""))
		if (!self.estaEnfrente().isEmpty()) {
			self.estaEnfrente().first().recibirDanio(self.danio())
		}
	}

}

class Enemigo inherits Mortal {

	const expEntregadaBase = 50
	const oroEntregadoBase = 10
	const heroe = null

//	override method recibirDanio(dmg) {
//		super(dmg)
//		self.morir()
//	}

	override method entregarRecompensa() {
		heroe.ganarExp(self.expEntregada())
		heroe.ganarOro(self.oroEntregado())
	}

	method expEntregada() {
		return (expEntregadaBase / heroe.nivel()).roundUp()
	}

	method oroEntregado() {
		return oroEntregadoBase 
	}

	override method gameOver() {
	}

	method heroe(_heroe) = _heroe

	override method mover(asd) {
	}

	override method atacar() {
		game.onTick(750, "disparar", {crear.hechizo(self).serInvocado(150, self.danio())})			
	}

	override method danio() {
		return 100
	}
}

