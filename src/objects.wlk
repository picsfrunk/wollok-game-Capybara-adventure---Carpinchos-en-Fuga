import wollok.game.* 
import enemies.*
import capybara.*
import randomizer.*
import generador.*

class Objects {
	var property position = game.at(0,0)
	method atravesable() = true
	method isEnemy() = false
	method borrar()	
	method gravedad() {
		if(position.y() >= 0 ) {
			position = abajo.siguiente(position)
		}
		else{
			game.removeVisual(self)
			self.borrar()
		}
	}	
	method crash(visual){
		
	}
}
class Bottle inherits Objects {
	method isBottle() = true
	override method borrar(){
		bottleGenerator.borrar(self)
	}	
}
class Beer inherits Bottle {
	method image() = "beer.png"	
}
class Tequila inherits Bottle {
	method image() = "tequila.png"	
}

class Birkir inherits Bottle {
	method image() = "birkir.png"	
}
class Obstacles {
	method atravesable() = false
	
} 
class Stump inherits Obstacles {
	method image() = "stump.png"		
	
}
object wall inherits Obstacles {
	method image() = "wall.png"		
	
}
object fence inherits Obstacles {
	method image() = "fence.png"
	
}
class Llave  {
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