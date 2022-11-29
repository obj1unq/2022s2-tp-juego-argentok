import wollok.game.*
import items.*
import seresVivos.*
import escenarios.*
import estadisticas.*


object configuracion {

	var heroe = null
	
	var juegoIniciado = false

	method comandos() {
		keyboard.left().onPressDo({ heroe.mover(izquierda)})
		keyboard.right().onPressDo({ heroe.mover(derecha)})
		keyboard.up().onPressDo({ heroe.mover(arriba)})
		keyboard.down().onPressDo({ heroe.mover(abajo)})
		keyboard.a().onPressDo({ heroe.atacar()})
		keyboard.f().onPressDo({ heroe.interactuarConTodos()})
		keyboard.p().onPressDo({game.say(heroe, heroe.decirNivelYExp())})
		keyboard.u().onPressDo({game.say(heroe, heroe.decirStats())})
		keyboard.q().onPressDo({game.say(heroe, heroe.decirVida())})
		keyboard.w().onPressDo({game.say(heroe, heroe.decirMana())})
		keyboard.y().onPressDo({ game.addVisual(tester.dummie(heroe))})
		keyboard.m().onPressDo({self.inicioDelJuegoMago()})
		keyboard.n().onPressDo({self.inicioDelJuegoGuerrero()})
	}
	
	method anularTeclasMN() {
		keyboard.m().onPressDo({null})
		keyboard.n().onPressDo({null})
	}
	
	method inicioDelJuegoMago() {
		if (!juegoIniciado) {
		self.anularTeclasMN()
		heroe = mago
		crear.mago_()
		juegoIniciado = true
		}
	}
	
	method inicioDelJuegoGuerrero() {
		if (!juegoIniciado) {
			self.anularTeclasMN()		
			heroe = guerrero
			crear.guerrero_()
			juegoIniciado = true
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
		guerrero.position(game.at(0,0))
		guerrero.equiparArma(self.espada())
		guerrero.curarse(250)
		game.addVisual(guerrero)
	}
	
	method mago_() {
		inteligencia.subirStat(30)
		agilidad.subirStat(10)
		salud.subirStat(150)
		manaMax.subirStat(250)
		
		mago.image("Mago_abajo.png")
		mago.position(game.at(0,0))
		mago.equiparArma(self.baculo())
		mago.curarse(150)
		mago.regenerarMana(250)
		game.addVisual(mago)
	}
	
	method espada() {
		return new Arma(puntosDeDanio = 100)
	}
	
	method baculo() {
		return new Arma(puntosDeDanio = 75)
	}
}

object tester {
//esto es para testar

	

	method dummie(_heroe) {
		return new Enemigo(image = "pepita.png", position = game.at(2,2),vida = 300, heroe = _heroe)
		
	}
	
	method item() {
		return new Item()
	}

}

object pistaDePrueba {

	method prueba1() {
		game.cellSize(32)
		
		//const tito = new Guerrero(image = "MagoSur.png", position = game.at(0,0), armaEquipada = tester.espada())
		//game.addVisual(tester.dummie(tito))
		//game.addVisual(tester.item())
		//game.addVisual(tito)

		configuracion.comandos()
		//game.addVisual(enemigo)
		//mapaActual.mapa(explanada)
		//mapaActual.inicializarMapa()
	}
}



