import wollok.game.* 
import objects.*
import enemies.*


object capybara {

	var property position = game.at(0,0)
	var property sufijo = "inicial"
	
	method image() = "capy_" + self.sufijo() + ".png"		
	
	method mover(direccion) {
//		self.validarPosition(proximaPosition)
		self.sufijo(direccion)
		position=direccion.siguiente(position)
	
//		position = proximaPosition		
	}

	
}

object mover {
	
	
}