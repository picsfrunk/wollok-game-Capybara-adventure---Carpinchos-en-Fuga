import wollok.game.* 
import enemies.*
import capybara.*
import randomizer.*
import generador.*
import sonido.*
class DefaultObjects {
	method isObstacle() = false
	method isEnemy() = false
	method isBottle() = false
	
}
class VisualObjects inherits DefaultObjects {
	var property position = game.at(0,0)
	method borrar()	
	method velocidad() {
		if(position.y() >= 0 ) {
			position = abajo.siguiente(position)
		}
		else{
			game.removeVisual(self)
			self.borrar()
		}
	}	
	method crash(visual)
}
class Bottle inherits VisualObjects {
	var property timeUp = 500
	override method isBottle() = true
	override method borrar(){
		bottleGenerator.borrar(self)
	}	
	override method crash(visual){
		visual.drinkBottle(self)
		game.removeVisual(self)
		self.borrar()
	}
	method drink(){
		humanGenerator.upTimeHumanGravity(timeUp)
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
class Obstacles inherits DefaultObjects {
	override method isObstacle() = true
	
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
object izquierda {
	method siguiente(position) = position.left(1)
}
object derecha {
	method siguiente(position) = position.right(1)		
}
object abajo {
	method siguiente(position) = position.down(1)
}
object display inherits DefaultObjects {
	var property message = ''
	var property position = game.at(game.width() - 3, game.height() - 1)
	method text() = 'Gravedad: ' + message
	method write(_message){
		message = _message
		}
		
}
object hp {
	
}
object time {
	
}
object arriba {
	method siguiente(position) = position.up(1)
}