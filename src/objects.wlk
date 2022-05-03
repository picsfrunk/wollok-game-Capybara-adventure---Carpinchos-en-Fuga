import wollok.game.* 
import enemies.*
import capybara.*

class Botellas {
	
}


class Beer inherits Botellas {
	var property position = game.at(0,0)
	method image() = "beer.png"	
	
}

class Tequila inherits Botellas {
	var property position = game.at(0,0)	
	method image() = "tequila.png"	
}

class Birkir inherits Botellas {
	var property position = game.at(0,0)	
	method image() = "birkir.png"	
}


class Key {
	var property position = game.at(0,0)
	method image() = "key.png"	
}

class Stump {
	var property position = game.at(0,0)	
	method image() = "stump.png"		
}


object cave {
	var property position = game.at(0,0)
	method image() = "cave.png"	
}


object wall {
	var property position = game.at(0,0)
	method image() = "wall.png"		
}

object fence {
	var property position = game.at(0,0)
	method image() = "fence.png"		
}

