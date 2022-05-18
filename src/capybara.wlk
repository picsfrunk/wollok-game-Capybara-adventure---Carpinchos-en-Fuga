import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*

object capybara {
	var property position = game.at(game.width().div(2)-1,0)
	var property sufijo = "inicial"
	var property life = 100
	var property nextPosition = game.at(0,0)
	var property tGravity = 750
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
		if (   (_nextPosition.x() == 0) 
			or (_nextPosition.x() == game.width() - 1) 
			or (! self.puedeSaltar(_nextPosition) )
			or (_nextPosition.y() == 2) )
			nextPosition = position	
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
		game.schedule(500, { self.gravityOn() })
	}
	method gravityOn(){
		game.onTick(tGravity, "CAPYGRAVITY", { self.gravity()})					
	}
	method loseLives(damage){
		life = life - damage
		game.say(self, self.life().toString())
	}
	method drinkBottle(bottle){
		
	}
}

