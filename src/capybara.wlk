import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*


object capybara {

	var property position = game.at(0,0)
	var property sufijo = "inicial"
	
	method image() = "capy_" + self.sufijo() + ".png"		
	
	method mover(direccion) {
		const proximaPosition=direccion.siguiente(position)
		self.validarPosition(proximaPosition)
		self.sufijo(direccion)
		position = proximaPosition		
	}
	
	method validarPosition(_position) {
		validador.validarPosition(_position)
		self.puedeSaltar(_position)
	}	
	

	
	method gravedad() {
		const siguiente = abajo.siguiente(position)
		if(position.y() > 0 && self.puedeSaltar(siguiente)) {
			position = abajo.siguiente(position)
		}
	}
	
	method puedeSaltar(_position) {
		return 	game.getObjectsIn(_position).
				all({visual => visual.atravesable()} )	
	}		
	
}

object mover {
	
	
}