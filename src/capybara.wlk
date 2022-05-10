import wollok.game.* 
import objects.*
import enemies.*


object capybara {

	var property position = game.at(0,0)
	var property sufijo = ""
	
	method image() = "capy_" + self.sufijo() + ".png"		
	
	method mover(direccion) {
		var proximaPosition=direccion.siguiente(position)
//		self.validarPosition(proximaPosition)
		self.sufijo(direccion)
		position = proximaPosition		
	}

	
}

object mover {
	
	
}