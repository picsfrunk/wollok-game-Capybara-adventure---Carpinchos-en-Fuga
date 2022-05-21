import wollok.game.* 
import objects.*
import capybara.*
import randomizer.*
import niveles.*
import generador.*
import sonido.*

class Enemy inherits objects.VisualObjects {
	override method isEnemy() = true
}
class Human inherits Enemy{
	var sufijo 
	const damage = 5
	method image() = "human_worker" + sufijo.toString() + ".png"	
	override method borrar(){
		humanGenerator.borrar(self)
	}
	override method crash(visual){
		visual.loseLives(damage)
		visual.shock()
//		game.removeVisual(self)
	}
}
class AnimalControl inherits Human {
	
	override method image() = "animal_control" + sufijo.toString() + ".png"	
}
class Aligator inherits Enemy {
	
	method image() = "aligator.png"	
	
}
class Snake inherits Enemy {

	
	method image() = "snake.png"		
		
}

