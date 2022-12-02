import wollok.game.*
import items.*
import seresVivos.*
import escenarios.*
import enemigos.*
import estadisticas.*
import proyectil.*



object configuracion {


	var property heroe = null

	var juegoIniciado = false

	method comandos() {
		keyboard.left().onPressDo({ heroe.mover(izquierda)})
		keyboard.right().onPressDo({ heroe.mover(derecha)})
		keyboard.up().onPressDo({ heroe.mover(arriba)})
		keyboard.down().onPressDo({ heroe.mover(abajo)})
		keyboard.num1().onPressDo({ heroe.comprar()})
		keyboard.num2().onPressDo({ heroe.vender()})
		keyboard.num3().onPressDo({ heroe.consultar()})
		keyboard.q().onPressDo({ game.say(heroe, heroe.decirVida())})
		keyboard.y().onPressDo({ tester.dummie()})
		keyboard.w().onPressDo({ game.say(heroe, heroe.decirMana())})
		keyboard.a().onPressDo({ heroe.atacar()})
		keyboard.s().onPressDo({ heroe.hechizo()})
		keyboard.t().onPressDo({ teclas.cambiarImagen()})
		keyboard.d().onPressDo({ heroe.defenderse()})
		keyboard.f().onPressDo({ heroe.interactuar()})
		keyboard.z().onPressDo({ game.say(heroe, heroe.decirOro())})
		keyboard.x().onPressDo({ game.say(heroe, heroe.decirNivelYExp())})
		keyboard.c().onPressDo({ game.say(heroe, heroe.decirStats())})
		keyboard.v().onPressDo({ game.say(heroe, heroe.decirInventario())})
		keyboard.m().onPressDo({ self.inicioDelJuegoMago()})
		keyboard.n().onPressDo({ self.inicioDelJuegoGuerrero()})
	}
	
	method juegoIniciado(){
		return juegoIniciado // pongo este getter porque necesito saber si el juego esta iniciali
	}
	
	method inicioDelJuego() {
			if (!juegoIniciado) {	
			juegoIniciado = true
			
		}
	}
	
	method inicioDelJuegoMago() {
			self.inicioDelJuego()
			heroe = mago
			crear.mago_()
			game.removeVisual(mapaActual)
			mapaActual.cambiarMapa(explanada)
			game.addVisual(teclas)
	}

	method inicioDelJuegoGuerrero() {	
			self.inicioDelJuego()
			heroe = guerrero
			crear.guerrero_()
			game.removeVisual(mapaActual)
			mapaActual.cambiarMapa(explanada)
			game.addVisual(teclas)
	}
}

object derecha {

	method siguiente(posicion) {
		return posicion.right(1)
	}
	
	method opuesto() = izquierda
	
	method siguiente() = abajo
	
	method anterior() = arriba
}

object izquierda {

	method siguiente(posicion) {
		return posicion.left(1)
	}
	
	method opuesto() = derecha
	
	method siguiente() = arriba
	
	method anterior() = abajo
}

object arriba {

	method siguiente(posicion) {
		return posicion.up(1)
	}
	
	method opuesto() = abajo
	
	method siguiente() = izquierda
	
	method anterior() = derecha
}

object abajo {

	method siguiente(posicion) {
		return posicion.down(1)
	}
	
	method opuesto() = arriba
	
	method siguiente() = derecha
	
	method anterior() = izquierda
}

object ejes {
	method validarEjeX(direccion, posicion, xMin, xMax) {
		return direccion.siguiente(posicion).x().between(xMin, xMax)
	}

	method validarEjeY(direccion, posicion, yMin, yMax) {
		return direccion.siguiente(posicion).y().between(yMin, yMax)
	}
}

object crear {

	method guerrero_() {
		fuerza.subirStat(25)
		agilidad.subirStat(20)
		salud.subirStat(250)
		guerrero.image("Guerrero_abajo.png")
		guerrero.position(game.at(0, 0))
		guerrero.armaEquipada(espada)
		guerrero.curarse(250)
		game.addVisual(guerrero) //agrego visual cuando instancio el mapa (tengo que hacerlo asi porque cada vez que cambio de mapa tengo que sacar y poner el visual)
	}

	method mago_() {
		inteligencia.subirStat(30)
		agilidad.subirStat(10)
		salud.subirStat(150)
		manaMax.subirStat(250)
		mago.image("Mago_abajo.png")
		mago.position(game.at(0, 0))
		mago.armaEquipada(barita)
		mago.curarse(150)
		mago.regenerarMana(250)
		game.addVisual(mago) //agrego visual cuando instancio el mapa (tengo que hacerlo asi porque cada vez que cambio de mapa tengo que sacar y poner el visual)
	}
	
	method hechizo(heroe){
		return new Proyectil(position = heroe.enFrente())
	}
}

object tester {
	
//esto es para testar
	method dummie() {
		const enemigo = self.unEnemigoVertical()
		game.addVisual(enemigo)
		//enemigo.atacar()
		enemigo.movimiento()
	}
	
	method unEnemigoVertical() {
		return new Enemigo(image = "esqueleto_abajo.png", position = game.at(9,5), vida = 2500, sentidoActual = abajo)
	}
	
	method unEnemigoHorizontal() {
		return new Enemigo(image = "esqueleto_derecha.png", position = game.at(9,5), vida = 2500, sentidoActual = derecha)
	}
}


object sprite {
	
	method deAccion(heroe, tiempo, imagenCon, imagenSin) {
		heroe.image(imagenCon)
		game.schedule(tiempo, {heroe.image(imagenSin)})
	}
}


object pistaDePrueba {


	method prueba1() {
		
		game.cellSize(32)
		game.height(10)
		game.width(15)
  		game.addVisual(mapaActual)
  		
		
		game.title("Argentok")	
			
		configuracion.comandos()
		// tester.dummie()
		// mapaActual.mapa(explanada)
		//mapaActual.inicializarMapa()
	}
}




