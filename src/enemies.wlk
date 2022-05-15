import wollok.game.* 
import objects.*
import capybara.*
import randomizer.*
import niveles.*
class Enemy {
	var property position = game.at(0,0)
	method gravedad() {
		if(position.y() >= 0 ) {
			position = abajo.siguiente(position)
		}
		else{
			game.removeVisual(self)
		}
			
	}	
	method isEnemy() = true
	
}
class Human inherits Enemy{
	var property sufijo = "worker2"
	
	method image() = "human_" + self.sufijo().toString() + ".png"	
	
}
class AnimalControl inherits Enemy {
	var property sufijo = ""
	
	method image() = "animal_control_" + self.sufijo() + ".png"	
}
class WildAnimal inherits Enemy {

	
	
}
class Aligator inherits WildAnimal {
	
	method image() = "aligator.png"	
	
}
class Snake inherits WildAnimal {

	
	method image() = "snake.png"		
		
}

