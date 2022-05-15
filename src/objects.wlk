import wollok.game.* 
import enemies.*
import capybara.*
import randomizer.*


class Botella {
	method atravesable() = true
	
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


class Obstaculos {
	method atravesable() = false
	
} 

class Stump inherits Obstaculos {
	var property position = game.at(0,0)	
	method image() = "stump.png"		
	
}

object wall inherits Obstaculos {
	var property position = game.at(0,0)
	method image() = "wall.png"		
	
}

object fence inherits Obstaculos {
	var property position = game.at(0,0)
	method image() = "fence.png"
	
}


class Llave {
	var property position = game.at(0,0)
	method image() = "key.png"	
	method atravesable() = true
	
}


object cave {
	var property position = game.at(0,0)
	method image() = "cave.png"	
	method atravesable() = true
	
}





object vida {
	
}

object tiempo {
	
}


object izquierda {
	method siguiente(position) = position.left(1)
}

object derecha {
	method siguiente(position) = position.right(1)		
}


object abajo {
	method siguiente(position) = position.down(1)
}

object arriba {
	method siguiente(position) = position.up(1)
}
