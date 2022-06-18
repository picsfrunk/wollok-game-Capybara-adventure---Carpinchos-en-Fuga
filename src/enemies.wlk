import wollok.game.*
import objects.*
import capybara.*
import randomizer.*
import niveles.*
import generador.*
import sonido.*

class Enemy inherits objects.VisualObjects {
	//override method isEnemy() = true
	const property damage = 5
	override method crash(visual){
		visual.loseLives(damage)
		visual.shock()
	}
}
class Human inherits Enemy{
	var sufijo 
	method image() = "human_worker" + sufijo.toString() + ".png"	
	override method borrar(){
		humanGenerator.borrar(self)
	}
}
class AnimalControl inherits Human {
	override method image() = "animal_control" + sufijo.toString() + ".png"	
	override method borrar(){
		animalControlGenerator.borrar(self)
	}
}
	
class Swimmer inherits Human {
	override method image() = "swimmer_" + sufijo.toString() + ".png"	
	override method borrar(){
		swimmerGenerator.borrar(self)
	}
}	
class Predator inherits Enemy (damage = 10){
	var sufijo
	method image() = "predator_" + sufijo.toString() + ".png"				
	override method borrar(){
		predatorGenerator.borrar(self)
	}
}

