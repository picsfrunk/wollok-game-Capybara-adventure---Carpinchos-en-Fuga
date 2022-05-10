import wollok.game.* 
import enemies.*
import capybara.*

class Botella {
	
}


class Beer inherits Botella {
	var property position = game.at(0,0)
	method image() = "beer.png"	
	
}

class Tequila inherits Botella {
	var property position = game.at(0,0)	
	method image() = "tequila.png"	
}

class Birkir inherits Botella {
	var property position = game.at(0,0)	
	method image() = "birkir.png"	
}


class Llave {
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


object vida {
	
}

object tiempo {
	
}


object izquierda {
	
	method siguiente(position) {
		return 	position.left(1)
	}
}

object derecha {
	method siguiente(position) {
		return 	position.right(1)		
	}	
}