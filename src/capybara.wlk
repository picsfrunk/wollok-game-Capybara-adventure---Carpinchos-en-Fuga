import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*


object capybara {

	var property position = game.at((game.width() / 2) - 1,0)
	var property sufijo = "inicial"
	
	method image() = "capy_" + self.sufijo() + ".png"		
	
	method mover(direccion) {
		const proximaPosition = direccion.siguiente(position)
		self.validarPosition(proximaPosition)
		self.sufijo(direccion.toString())
		position = proximaPosition		
	}
	

	
	method validarPosition(_position) {
		validador.validarPosition(_position)
		if (! self.puedeSaltar(_position))
			self.error("No puedo saltar")
	}	
	

	method puedeSaltar(_position) {
		return 	game.getObjectsIn(_position).
				all({visual => visual.atravesable()} )	
	}		
	
	
	method gravedad() {
		const siguiente = abajo.siguiente(position)
		if(position.y() > 0 && self.puedeSaltar(siguiente)) {
			position = abajo.siguiente(position)
		}
	}
	
}

