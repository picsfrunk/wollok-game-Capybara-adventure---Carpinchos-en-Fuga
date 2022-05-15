import wollok.game.* 
import enemies.*
import capybara.*
import randomizer.*


class Bottle {
	method atravesable() = true
	
}
class Beer inherits Bottle {
	var property position = game.at(0,0)
	method image() = "beer.png"	
	
}
class Tequila inherits Bottle {
	var property position = game.at(0,0)	
	method image() = "tequila.png"	
}

class Birkir inherits Bottle {
	var property position = game.at(0,0)	
	method image() = "birkir.png"	
}
class Obstacles {
	method atravesable() = false
	
} 
class Stump inherits Obstacles {
	var property position = game.at(0,0)	
	method image() = "stump.png"		
	
}
object wall inherits Obstacles {
	var property position = game.at(0,0)
	method image() = "wall.png"		
	
}
object fence inherits Obstacles {
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
object hp {
	
}
object time {
	
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