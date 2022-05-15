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
//			humanGenerator.borrar(self) // OJO!! CAMBIAR A EL GENERICO
		}
		
			
	}	
	
}
class Human inherits Enemy{
	var property sufijo = "worker2"
	
	method image() = "human_" + self.sufijo().toString() + ".png"	
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

