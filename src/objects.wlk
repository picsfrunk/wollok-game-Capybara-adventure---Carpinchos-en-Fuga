import wollok.game.* 
import enemies.*
import capybara.*
import randomizer.*
import generador.*
import sonido.*
import niveles.*

class DefaultObjects {
	method isObstacle() = false
//	method isEnemy() = false
//	method isBottle() = false
//	method isPredator() = false
	method passThrough() = false	
//	method isKey() = false
}
//VisualObjects seran los que tengan gravedad e iran apareciendo en pantalla aleatoriamente
class VisualObjects inherits DefaultObjects {
	var property position = game.at(0,0)
	method crash(visual)
	method borrar()	
	method gravity() {
		if(position.y() >= 0 ) {
			position = abajo.siguiente(position)
		}
		else{
			game.removeVisual(self)
			self.borrar()
		}
	}	
}
class InvisibleExit inherits DefaultObjects {
//	override method passThrough() = true
		
	method show(){
		game.addVisualIn(self,game.at(game.width() - 2,0))
	}
	method crash(visual){
		visual.levelUp()
	}
}
class Exit inherits DefaultObjects{
	method image() = nivelActual.is().exit()
	method show(){
		game.addVisualIn(self,game.at(game.width() - 1,0))
	}
}


class Llave inherits VisualObjects {
	method image() = "llave.png"	
//	override method passThrough() = true
//	override method isKey() = true
	override method borrar(){
		keyGenerator.borrar(self)
	}		
	override method crash(visual){
		visual.addKey(self)
		if(game.hasVisual(self))
			game.removeVisual(self)
		self.borrar()		
	}
}
class Bottle inherits VisualObjects {
//	override method isBottle() = true
	override method borrar(){
		bottleGenerator.borrar(self)
	}	
	override method crash(visual){
		visual.drinkBottle(self)
		game.removeVisual(self)
		self.borrar()
	}
	method taken(visual)
}
class Beer inherits Bottle { // desacelera el tiempo osea sube el tiempo de gravedad
	var property timeDown = 200
	method image() = "beer.png"	
	override method taken(visual){
		visual.decelerate(timeDown)
	}				
}
class Tequila inherits Bottle { //acelera tiempo osea baja el tiempo de gravedad
	var property timeUp = 200
	method image() = "tequila.png"	
	override method taken(visual){
		visual.acelerate(timeUp)
	}	
}
class Birkir inherits Bottle { //aumenta la vida 
	var property lifeUp = 10
	method image() = "birkir.png"	
	override method taken(visual){
		visual.winLives(lifeUp)
	}		
}
class Obstacles inherits VisualObjects {
	const damage = 10
	override method isObstacle() = true
	override method borrar(){
		obstacleGenerator.borrar(self)
	}
	override method gravity(){
		super()
		if (position.y() == 0 ){
			self.borrar()
			game.schedule(5000,{game.removeVisual(self)})
		}
	}

	override method crash(visual){
		visual.loseLives(damage)
		visual.shock()	
	}
} 
class Wall inherits Obstacles {
	method image() = "wall.png"	
}
class Fence inherits Obstacles {
	var sufijo
	method image() = "fence_" + sufijo.toString() + ".png"
}
class Stump inherits Obstacles {
	var sufijo
	method image() = "stump_" + sufijo.toString() + ".png"		
}
object cave inherits DefaultObjects {
	method image() = "cave.png"	
	//override method passThrough() = true
	method crash(visual){
		visual.levelUp()
	}
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
object display inherits DefaultObjects {
	var property message = ''
	var property position = game.at(game.width() - 3, game.height() - 1)
	method text() = 'VIDA: '+ '\n' + message
	method write(_message){
		message = _message
		}		
}
object display2 inherits DefaultObjects {
	var property message = ''
	var property position = game.at(game.width() - 8, game.height() - 1)
	method textColor() = colores.amarillo()
	method text() = '\n' + message
	method write(_message){
		message = _message
		}		
}
object display3 inherits DefaultObjects {
	var property message = ''
	var property position = game.at(2, game.height() - 1)
	method text() = 'NIVEL ' + '\n' + message
	method textColor() = colores.naranja()
	method write(_message){
		message = _message
		}		
}
object colores {

	const property verde = "00FF00FF"
	const property rojo = "FF0000FF"
	const property naranja = "F99500FF"
	const property amarillo = "#FFF633FF"

}
object hp inherits DefaultObjects {
	var property position = game.at(0, 13)
	method image() = "hp_" + (capybara.life()).toString() + ".png"	
}
object keychain inherits DefaultObjects {
	var property position = game.at(6, 13)
	method image() = "time_" + (capybara.keyscount()).toString() + ".png"
}
class Counter inherits DefaultObjects{
	
}
object time inherits Counter {
	var property counter = 60
	var property position = game.at(12, 13)
	method resetCounter() {counter = 60}
	method image() = "time_" + counter.toString() + ".png"
	method countBackwards() {
		game.removeVisual(self)
		counter = counter - 1
		game.addVisual(self)
	}	
}
object fade inherits Counter {
	var property counter = 5
	var property position = game.at(0, 0)
	method image() = "fade_" + counter.toString() + ".png"
	method countBackwards() {
		game.removeVisual(self)
		if (counter==0) {counter=0}
		else {counter = counter - 1}
		game.addVisual(self)
	}
}