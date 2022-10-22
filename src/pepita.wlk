import wollok.game.*

object hero inherits Mortal {

	var property position = game.center()
	var property image = "pepita.png"
	var inventario = []

	method agarrarItem(item) 
	{
		inventario.add(item) 
	}

}

