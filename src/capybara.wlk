import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*
import sonido.*
import generador.*

object capybara inherits objects.DefaultObjects {
	var property position = game.at(game.width().div(2)-1,0)
	var property sufijo = "inicial"
	var property life = 100
	var property nextPosition = game.at(0,0)
	//agregar limite de cero para perder
	method image() = "capy_" + self.sufijo() + ".png"		
	method mover(direccion) {
		nextPosition = direccion.siguiente(position)
		self.validarPosition(nextPosition)
		self.sufijo(direccion.toString())
		if (direccion.equals(arriba))
			game.schedule(1000, { self.mover(abajo) })
		position = nextPosition		
	}
	method validarPosition(_nextPosition) {
		if (   (_nextPosition.x() == 0) 
			or (_nextPosition.x() == game.width() - 1) 
			or (! self.puedeSaltar(_nextPosition) )
			or  (_nextPosition.y() == 2) 
			or (_nextPosition.y() < 0)
			) 
			nextPosition = position	
	}	
	method puedeSaltar(_position) {
		return 	game.getObjectsIn(_position).
				all({visual => ! visual.isObstacle() } )	
	}		
	method loseLives(damage){
		life = life - damage
		game.say(self, self.life().toString()) //sacar o cambiar despues de poner barrita de vida y hacer directamente metodo para eso
	}
	method winLives(how){
		life = life + how
		game.say(self, self.life().toString()) 	//sacar o cambiar despues de poner barrita de vida y hacer directamente metodo para eso	
	}
	method drinkBottle(bottle){
		bottle.taken(self)
//		game.say(self, humanGenerator.timeHumanGravity().toString() )
	}
	method shock(){
		self.sufijo("shock")
	}
	method lose(){
		
	}
	method win(){
		
	}
}

