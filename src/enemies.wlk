import wollok.game.* 
import objects.*
import capybara.*


class Humanos {
	var property position = game.at(0,0)
	var property sufijo = ""
	
	method image() = "human_" + self.sufijo() + ".png"
	
}

class AnimalControl {
	var property position = game.at(0,0)
	var property sufijo = ""
	
	method image() = "animal_control_" + self.sufijo() + ".png"	
}

class WildAnimals {

	
	
}

class Aligator inherits WildAnimals {
	var property position = game.at(0,0)

	
	method image() = "aligator.png"	
	
}

class Snake inherits WildAnimals {
	var property position = game.at(0,0)

	
	method image() = "snake.png"		
	
	
}

