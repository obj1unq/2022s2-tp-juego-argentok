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
		keyboard.p().onPressDo({ tester.dummie(5,7)})
		keyboard.o().onPressDo({ tester.dummie2(7,9)})
		keyboard.w().onPressDo({ game.say(heroe, heroe.decirMana())})
		keyboard.a().onPressDo({ heroe.atacar()})
		keyboard.s().onPressDo({ heroe.hechizo()})
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
//			game.removeVisual(mapaActual)
//			mapaActual.cambiarMapa(explanada)
		}
	}
	
	method inicioDelJuegoMago() {
			self.inicioDelJuego()
			heroe = mago
			crear.mago_()
	}

	method inicioDelJuegoGuerrero() {	
			self.inicioDelJuego()
			heroe = guerrero
			crear.guerrero_()
	}
}

object derecha {

	method siguiente(posicion) {
		return posicion.right(1)
	}
	
	method opuesta() = izquierda
	
	method siguiente() = abajo
	
	method anterior() = arriba
	
	method esDerecha(pos1, pos2) {
		return pos1.x() == pos2.x() + 1 and pos1.y() == pos2.y()
	}
	
	method darDireccion(pos1, pos2) {
		return if (self.esDerecha(pos1, pos2)) {
			self
		} else {
			izquierda.darDireccion(pos1, pos2)
		}
	}
}

object izquierda {

	method siguiente(posicion) {
		return posicion.left(1)
	}
	
	method opuesta() = derecha
	
	method siguiente() = arriba
	
	method anterior() = abajo
	
	method esIzquierda(pos1, pos2) {
		return pos1.x() == pos2.x() - 1 and pos1.y() == pos2.y()
	}
	
	method darDireccion(pos1, pos2) {
		return if (self.esIzquierda(pos1, pos2)) {
			self
		} else {
			arriba.darDireccion(pos1, pos2)
		}
	}
}

object arriba {

	method siguiente(posicion) {
		return posicion.up(1)
	}
	
	method opuesta() = abajo
	
	method siguiente() = izquierda
	
	method anterior() = derecha
	
	method esArriba(pos1, pos2) {
		return pos1.x() == pos2.x() and pos1.y() == pos2.y() + 1
	}
	
	method darDireccion(pos1, pos2) {
		return if (self.esArriba(pos1, pos2)) {
			self
		} else {
			abajo.darDireccion(pos1, pos2)
		}
	}
}

object abajo {

	method siguiente(posicion) {
		return posicion.down(1)
	}
	
	method opuesta() = arriba
	
	method siguiente() = derecha
	
	method anterior() = izquierda
	
	method esAbajo(pos1, pos2) {
		return pos1.x() == pos2.x() and pos1.y() == pos2.y() - 1
	}
	
	method darDireccion(pos1, pos2) {
		return if (self.esAbajo(pos1, pos2)) {
			self
		} else {
			derecha.darDireccion(pos1, pos2)
		}
	}
}

object ejes {
	method validarX(direccion, posicion, xMin, xMax) {
		return direccion.siguiente(posicion).x().between(xMin, xMax)
	}

	method validarY(direccion, posicion, yMin, yMax) {
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
	method dummie(pos1, pos2) {
		const enemigo = self.unEnemigoVertical(pos1, pos2)
		game.addVisual(enemigo)
		enemigo.movimiento()
	}
	
	method dummie2(pos1, pos2) {
		const enemigo = self.unEnemigoHorizontal(pos1, pos2)
		game.addVisual(enemigo)
		enemigo.movimiento()
	}
	
	method unEnemigoVertical(pos1, pos2) {
		return new Enemigo(image = "esqueleto_abajo.png", position = game.at(pos1,pos2), vida = 2500, sentidoActual = abajo)
	}
	
	method unEnemigoHorizontal(pos1, pos2) {
		return new Enemigo(image = "esqueleto_derecha.png", position = game.at(pos1, pos2), vida = 2500, sentidoActual = derecha)
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
		
		game.height(10)
		game.width(15)
		game.title("Argentok")
		game.cellSize(32)
				
//		game.addVisual(mapaActual)	
		configuracion.comandos()
		tester.dummie(3,5)
		tester.dummie2(7,9)
//		mapaActual.mapa(explanada)
//		mapaActual.inicializarMapa()
	}
}




