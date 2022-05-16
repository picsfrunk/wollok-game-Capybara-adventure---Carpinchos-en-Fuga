import wollok.game.* 
import objects.*
import capybara.*
import randomizer.*
import niveles.*
import generador.*
class Enemy {
	var property position = game.at(0,0)
	method isEnemy() = true
	method atravesable() = true
	method borrar()
	method gravedad() {
		if(position.y() >= 0 ) {
			position = abajo.siguiente(position)
		}
		else{
			game.removeVisual(self)
			self.borrar()
		}
	}	
}
class Human inherits Enemy{
	var sufijo 
	
	method image() = "human_worker" + sufijo.toString() + ".png"	
	override method borrar(){
		humanGenerator.borrar(self)
	}
	
}
class AnimalControl inherits Enemy {
	var property sufijo = ""
	
	method image() = "animal_control_" + self.sufijo() + ".png"	
}
class Aligator inherits Enemy {
	
	method image() = "aligator.png"	
	
}
class Snake inherits Enemy {

	
	method image() = "snake.png"		
		
}

