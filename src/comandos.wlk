import wollok.game.*
import items.*
import seresVivos.*

object configuracion {

	method comandos(heroe) {
		keyboard.left().onPressDo({ heroe.mover(izquierda)})
		keyboard.right().onPressDo({ heroe.mover(derecha)})
		keyboard.up().onPressDo({ heroe.mover(arriba)})
		keyboard.down().onPressDo({ heroe.mover(abajo)})
		keyboard.a().onPressDo({ heroe.atacar()})
		keyboard.f().onPressDo({ heroe.interactuar()}
		keyboard.p().onPressDo({game.addVisual(tester.dummie())})
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

	method dummie() {
		return new Enemigo(image = "pepita.png", position = game.at(2,2),vida = 300)
		
	}
	
	method item() {
		return new Item()
	}

}

object pistaDePrueba {

	method prueba1() {
		const tito = new Heroe(image = "player.png", position = game.at(1,2), armaEquipada = tester.espada())
		configuracion.comandos(tito)
		game.addVisual(tito)
		game.addVisual(tester.dummie())
		game.addVisual(tester.item())
	}
}

