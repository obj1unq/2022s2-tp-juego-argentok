import wollok.game.*
import items.*
import seresVivos.*
import escenarios.*


object configuracion {

	method comandos(heroe) {
		keyboard.left().onPressDo({ heroe.mover(izquierda)})
		keyboard.right().onPressDo({ heroe.mover(derecha)})
		keyboard.up().onPressDo({ heroe.mover(arriba)})
		keyboard.down().onPressDo({ heroe.mover(abajo)})
		keyboard.a().onPressDo({ heroe.atacar()})
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

object tester {
//esto es para testar

	method espada() {
		return new Arma(puntosDeDanio = 100)
	}
/*
	method dummie() {
		return new Enemigo(vida = 300)
	}
*/
}

object pistaDePrueba {

	method prueba1() {
		game.cellSize(32)
		
		const tito = new Heroe(image = "MagoSur.png", position = game.at(0,0), armaEquipada = tester.espada())
		configuracion.comandos(tito)
		game.addVisual(tito)
		//game.addVisual(enemigo)
		mapaActual.mapa(explanada)
		mapaActual.inicializarMapa()
		
		
		
		
	}

}



