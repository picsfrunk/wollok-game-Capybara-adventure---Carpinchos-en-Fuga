import wollok.game.* 
import enemies.*
import capybara.*
import randomizer.*
import generador.*
import sonido.*
import niveles.*

class DefaultObjects {
	method isObstacle() = false
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
			self.borrar()
			game.removeVisual(self)
		}
	}
	method loseLives(damage){
		game.removeVisual(hp)
		const newLife = capybara.life() - damage
		if (newLife < 0 )
			capybara.lose()
		else
			capybara.life(newLife)
		game.addVisual(hp)
	}
}

class InvisibleExit inherits DefaultObjects {
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
object cave inherits DefaultObjects {
	method image() = "cave.png"	
	method crash(visual){
		visual.levelUp()
	}
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
	var property counter
	var property position
	method image()
	method countBackwards()
}
object time inherits Counter (counter = 60, position = game.at(12, 13) ){
	method resetCounter() {counter = 60}
	override method image() = "time_" + counter.toString() + ".png"
	override method countBackwards() {
		game.removeVisual(self)
		counter = counter - 1
		game.addVisual(self)
	}	
}
object fade inherits Counter (counter = 5, position = game.at(0, 0)){
	override method image() = "fade_" + counter.toString() + ".png"
	override method countBackwards() {
		game.removeVisual(self)
		if (counter==0) {counter=0}
		else {counter = counter - 1}
		game.addVisual(self)
	}
}

class Llave inherits VisualObjects {
	method image() = "llave.png"	
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
	var property cartel
//	override method isBottle() = true
	override method borrar(){
		bottleGenerator.borrar(self)
	}	
	override method crash(visual){
		visual.drinkBottle(self)
		game.removeVisual(self)
		self.borrar()
	}
	method taken(visual){
		if(! game.hasVisual(cartel)){
			game.addVisual(cartel)
			game.schedule(3000, {game.removeVisual(cartel)})
			}
	}
}
class Beer inherits Bottle (cartel = cartelBeer){ // desacelera el tiempo osea sube el tiempo de gravedad
	var property timeDown = 100
	method image() = "beer.png"	
	override method taken(visual){
		super(cartel)
//		console.println("Beer timeGravity ")
		nivelActual.is().desacelerar(timeDown)
	}				
}
class Tequila inherits Bottle (cartel = cartelTequila) { //acelera tiempo osea baja el tiempo de gravedad
	var property timeUp = 100
	method image() = "tequila.png"	
	override method taken(visual){
		super(cartel)
//		console.println("Tequila timeGravity ")
		nivelActual.is().acelerar(timeUp)
	}	
}
class Birkir inherits Bottle (cartel = cartelBirkir) { //aumenta la vida 
	var property lifeUp = 10
	method image() = "birkir.png"
	method winLives(won){
		game.removeVisual(hp)
		const newLife = capybara.life() + won
		if (newLife > capybara.maxLife() )
			capybara.life(capybara.maxLife()) 
		else
			capybara.life(newLife)
		game.addVisual(hp)
	}	
	override method taken(visual){
		super(cartel)
		self.winLives(lifeUp)
	}		
}

class CartelBotella {
	var property position = game.at(9, 13)
	method image()
}
object cartelBeer inherits CartelBotella {
	override method image() = "cartelBeer.png"
}
object cartelTequila inherits CartelBotella {
	override method image() = "cartelTequila.png"
}
object cartelBirkir inherits CartelBotella{
	override method image() = "cartelBirkir.png"
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
		self.loseLives(damage)
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

