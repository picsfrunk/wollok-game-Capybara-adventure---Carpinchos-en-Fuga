import wollok.game.*
import objects.*
import capybara.*
import randomizer.*
import niveles.*
import generador.*
import sonido.*

class Enemy inherits objects.VisualObjects {
	//override method isEnemy() = true
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
	}
}
class AnimalControl inherits Human {
	override method image() = "animal_control" + sufijo.toString() + ".png"	}

class Swimmer inherits Human {
	override method image() = "swimmer_" + sufijo.toString() + ".png"	}
	
class Predator inherits Enemy {
	
	var sufijo
	const damage = 10
	
	//override method isPredator() = true
	
	override method crash(visual){
		visual.loseLives(damage)
		visual.shock()
	}
	override method borrar(){
		predatorGenerator.borrar(self)
	}
	method image() = "predator_" + sufijo.toString() + ".png"				
}

