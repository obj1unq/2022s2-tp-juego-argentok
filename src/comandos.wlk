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
		keyboard.y().onPressDo({ game.addVisual(tester.dummie(heroe))})
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
	
	method inicioDelJuegoMago() {
		if (!juegoIniciado) {
			juegoIniciado = true
			heroe = mago
			game.removeVisual(mapaActual)
			mapaActual.cambiarMapa(explanada)
			crear.mago_()
		}
	}

	method inicioDelJuegoGuerrero() {
		if (!juegoIniciado) {	
			juegoIniciado = true
			heroe = guerrero
			game.removeVisual(mapaActual)
			mapaActual.cambiarMapa(explanada)
			crear.guerrero_()
		}
	}
}

object derecha {

	method siguiente(posicion) {
		return posicion.right(1)
	}

}

object izquierda {

	method siguiente(posicion) {
		return posicion.left(1)
	}

}

object arriba {

	method siguiente(posicion) {
		return posicion.up(1)
	}

}

object abajo {

	method siguiente(posicion) {
		return posicion.down(1)
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
		//game.addVisual(guerrero) agrego visual cuando instancio el mapa (tengo que hacerlo asi porque cada vez que cambio de mapa tengo que sacar y poner el visual)
	}

	method mago_() {
		inteligencia.subirStat(30)
		agilidad.subirStat(10)
		salud.subirStat(150)
		manaMax.subirStat(250)
		mago.image("Mago_abajo.png")
		mago.position(game.at(0, 0))
		mago.armaEquipada(baculo)
		mago.curarse(150)
		mago.regenerarMana(250)
		//game.addVisual(mago) agrego visual cuando instancio el mapa (tengo que hacerlo asi porque cada vez que cambio de mapa tengo que sacar y poner el visual)
	}
	
	method hechizo(heroe){
		return new Proyectil(position = heroe.enFrente(), caster = heroe )
	}
}

object tester {

//esto es para testar
	method dummie(_heroe) {
		return new Enemigo(image = "pepita.png", position = game.center(), vida = 300, heroe = _heroe, ultimaDireccion = derecha)
	}
}


object sprite {
	
	method deHeroe(heroe, tiempo, imagenCon, imagenSin) {
		heroe.image(imagenCon)
		game.schedule(tiempo, {heroe.image(imagenSin)})
	}
}


object pistaDePrueba {


	method prueba1() {
		//const tito = new Heroe(image = "MagoSur.png", position = game.at(0, 0), armaEquipada = tester.espada(), oro = 100)
		//configuracion.comandos(tito)
		
		game.cellSize(32)
  		game.addVisual(mapaActual)
		/*
		game.addVisual(tito)
			// game.addVisual(tester.dummie())
		game.addVisual(tester.item())
			// me.addVisual(new Banco(position = game.at(6, 6)))
			// game.addVisual(enemigo)
		mapaActual.mapa(explanada)
		mapaActual.inicializarMapa()
*/
		
		game.height(10)
		game.width(15)
		game.title("Argentok")	
			
 		// me.addVisual(new Banco(position = game.at(6, 6)))
  		// game.addVisual(enemigo)
  		//mapaActual.mapa(explanada)
  		//mapaActual.inicializarMapa()
 
			// const tito = new Guerrero(image = "MagoSur.png", position = game.at(0,0), armaEquipada = tester.espada())
			// game.addVisual(tester.dummie(tito))
			// game.addVisual(tester.item())
			// game.addVisual(tito)
		configuracion.comandos()
		//tester.dummie(mago).atacar()
		 mapaActual.mapa(explanada)
		 mapaActual.inicializarMapa()
	}
}

/*object pistaDePrueba2 {
	
	method prueba2(){
		game.cellSize(32)
		
		const malito = new EnemigoHorizontal(image = "pepita.png", position = game.at(1,0),vida = 300, sentidoActual = derecha)
		const tito = new Heroe(image = "MagoSur.png", position = game.at(2,6), armaEquipada = tester.espada())
		game.addVisual(malito)
		game.addVisual(tito)
		game.onTick(500, "moverse", {malito.moverse()})
		configuracion.comandos(tito)
	}
}*/



