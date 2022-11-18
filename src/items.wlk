import wollok.game.*

class Item  
{
	
	//var valor
	
}

class Recurso inherits Item 
{
	
	
}

class Equipamento inherits Item 
{
	
	
}

class Arma inherits Equipamento {
	
	var puntosDeDanio
	
	method puntosDeDanio() = puntosDeDanio
}

class Armadura inherits Equipamento {
	
	var puntosDeArmadura
	
	method puntosDeArmadura() = puntosDeArmadura
}

class Casas {
	var property inventario = []
	//uso lista porque puede que hayan repetidos y los quiero conservar -- revisable
	var property image 
	
	method comprar(item)
	
	method vender(item)
	
	method depositar(item){
		inventario.add(item)
	}
	
	method retirar(item){
		self.validarExistencia(item)
		inventario.remove(item)
	}
	
	method puedeInteractuar(serVivo){
		return true
	}//tiene que validar que si es mago interactue solo con casaDeMagia y si es guerrero solo con casaDeArmaduras
	
	method validarExistencia(item) {
		if(not inventario.contains(item)){
			self.error("No tengo el objeto que buscas")
		} 
	}
}


class Banco inherits Casas {
	
	var property boveda = 0 // en la boveda va el oro
	
	override method image(){
		return "Banco.png"
	}
	
	method consultarOro(serVivo){
		game.say(self, "Tenes " + serVivo.oro() + "monedas de oro")
	}
	
	method depositarOro(cantOro){
		boveda =+ cantOro
	}
	
	method retirarOro(cantOro){
		self.validarCantidad(cantOro)
		boveda =- cantOro
	}
	
	method validarCantidad(cantOro) {
		if(cantOro > boveda){
			self.error("No tenes tanto oro para retirar")
		}
	}
	
	
}

class CasaDeMagia inherits Casas {
	
	
	
	override method puedeInteractuar(serVivo){
		return !(serVivo == mago)
	}
	
	override method comprar(item){
		
	}
	
	override method vender(item){
}

}


class CasaDeArmaduras inherits Casas {
	

	override method puedeInteractuar(serVivo){
		return !(serVivo == guerrero) 
	}

	override method comprar(item){
		
	}
	
	override method vender(item){
}

}



class Mercado inherits Casas {
	
	override method comprar(item){
		
	}
	
	override method vender(item){

}
	
}
