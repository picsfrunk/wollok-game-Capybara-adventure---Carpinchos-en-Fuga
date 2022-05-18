import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*
import sonido.*

object capybara {
	var property position = game.at(game.width().div(2)-1,0)
	var property sufijo = "inicial"
	var property life = 100
	var property nextPosition = game.at(0,0)
	//agregar limite de cero para perder
	method image() = "capy_" + self.sufijo() + ".png"		
	method isEnemy() = false
	method isBottle() = false
	method isObstacle() = false
	method mover(direccion) {
		nextPosition = direccion.siguiente(position)
		self.validarPosition(nextPosition)
		self.sufijo(direccion.toString())
		if (direccion.equals(arriba))
			self.stopGravity()
		position = nextPosition		
//		game.say(self, position.toString())
	}
	method validarPosition(_nextPosition) {
		if ( _nextPosition.x() == -1 )
			nextPosition = position	
		if ( _nextPosition.x() == game.width() )
			nextPosition = position 
		if (! self.puedeSaltar(_nextPosition))
			self.error("No puedo saltar")
	}	
	method puedeSaltar(_position) {
		return 	game.getObjectsIn(_position).
				all({visual => visual.atravesable()} )	
	}		
	method gravity() {
		if(position.y() > 0 ) 
			self.position(abajo.siguiente(position))
	}
	method stopGravity(){
		game.removeTickEvent("CAPYGRAVITY")
		game.schedule(300, {self.gravityOn()})
	}
	method gravityOn(){
		game.onTick(500, "CAPYGRAVITY", { self.gravity()})					
	}
	method loseLives(damage){
		life = life - damage
		game.say(self, self.life().toString())
	}
	method drinkBottle(bottle){
		
	}
}

