import enemies.*
import randomizer.*
import wollok.game.* 
import objects.*
import sonido.*
import niveles.*

class Factory {
	method random() = randomizer.emptyPosition()
	method randomLeft() = randomizer.emptyPositionLeft()
	
}
object humanFactory inherits Factory{
	//const suf = [1,2,3]
	method buildHuman()= nivelActual.humans() //new Human(sufijo=suf.anyOne(), position=self.random())
}
object predatorFactory inherits Factory{
	const suf = [1,2]
	method buildPredator() = new Predator (sufijo=suf.anyOne(), position=self.randomLeft())
}
object beerFactory inherits Factory{
	method buildBottle() = new Beer(position=self.random())
}
object tequilaFactory inherits Factory{
	method buildBottle() = new Tequila(position=self.random())
}
object birkirFactory inherits Factory{
	method buildBottle() = new Birkir(position=self.random())
}
object keyFactory inherits Factory {
	method buildKey() = new Llave(position=self.random())
}
object obstacleFactory inherits Factory { //otra opción: hacer una factory x obstáculo y tratarlo como las botellas

	method buildObstacle() = //new Wall(position=self.random())
		nivelActual.obstacles()
}

class ObjectGenerator {
	var property max
	const genObjects = []
	method borrar(obj) {
		genObjects.remove(obj)
	}
	method haveToGenerate() = genObjects.size() <= max
	method resetColection(){
		genObjects.clear()
	}
	method show(){
		self.resetColection()
	}
	
}
class EnemiesGenerator inherits ObjectGenerator {
//	var property timeGravity = nivelActual.es()
}
object humanGenerator inherits ObjectGenerator (max = 6){
	var property timeHumanGravity = nivel1.initTimeHumanGravity()
	var property timeHumanTickGen = nivel1.initTimeHumanGenerator()
	const timeGravityMax = 300
	method generate() {
		
//		console.println("Human Generator" + timeHumanTickGen)
		if(self.haveToGenerate()) {
			const newHuman = humanFactory.buildHuman()
			game.addVisual(newHuman)
			genObjects.add(newHuman)
		}
	}
	

	method onTickGenerator(){
//		console.println("Human Generator" + timeHumanTickGen)
		
		game.onTick(timeHumanTickGen, "HUMANS", { self.generate()  })	 		
	}
	method gravityOn(){
		game.onTick(timeHumanGravity, "HUMANGRAVITY", { 
			genObjects.forEach( { enemy => enemy.gravity()} )
		} )				
	}
	override method show(){
//		self.resetColection()
		super()
		self.onTickGenerator()
		self.gravityOn()
	}
	method upTimeHumanGravity(n){ //ver la manera de limitar despues
		if (timeHumanGravity < timeGravityMax){
			timeHumanTickGen = timeHumanTickGen - (n+200) //pruebas
			timeHumanGravity = timeHumanGravity - n
			self.refresh()			
		}
	}	
	method downTimeHumanGravity(n){
		if (timeHumanGravity < timeGravityMax){
			timeHumanTickGen = timeHumanTickGen + (n+200) //pruebas
			timeHumanGravity = timeHumanGravity + n
			self.refresh()			
		}
	}
	method refreshGravity(){
		display.write(timeHumanGravity.toString())
		game.removeTickEvent("HUMANGRAVITY")
		game.onTick(timeHumanGravity, "HUMANGRAVITY", { 
			genObjects.forEach( { enemy => enemy.gravity()} )
		} )		
	}
	method refreshTick(){
		game.removeTickEvent("HUMANS") //pruebas
		self.onTickGenerator()
	}
	method refresh(){
		self.refreshGravity()
		self.refreshTick()
	}
}

object bottleGenerator inherits ObjectGenerator (max = 3){
	const factories = [beerFactory, tequilaFactory, birkirFactory]
	method newBottle() = factories.anyOne().buildBottle()
	method generate() {
		if(self.haveToGenerate()) {
			const newBottle = self.newBottle()
			game.addVisual(newBottle)
			genObjects.add(newBottle)
		}
	}
	override method show(){
		super()
		game.onTick(5000, "BOTTLES", { self.generate() })
		game.onTick(500, "BOTTLESGRAVITY", { 
			genObjects.forEach( { bottle => bottle.gravity()} )
		} )		
	}	
}
object keyGenerator inherits ObjectGenerator (max = 1) {
	method newKey() = keyFactory.buildKey()
	method generate() {
		if(self.haveToGenerate()) {
			const newKey = self.newKey()
			game.addVisual(newKey)
			genObjects.add(newKey)
		}
	}
	override method show(){
//		self.resetColection()
		super()
		game.onTick(8000, "KEYS", { self.generate() })
		game.onTick(300, "KEYSGRAVITY", { 
			genObjects.forEach( { keys => keys.gravity()} )
		} )		
	}				
}

object obstacleGenerator inherits ObjectGenerator (max = 5){
	method newObstacle() = obstacleFactory.buildObstacle()
	method generate() {
//		max = 5
		if(self.haveToGenerate()) {
			const newObstacle = self.newObstacle()
			game.addVisual(newObstacle)
			genObjects.add(newObstacle)
		}
	}
	override method show(){
		super()
		game.onTick(5500, "OBSTACLE", { self.generate() })
		game.onTick(550, "OBSTACLEGRAVITY", { 
			genObjects.forEach( { obstacle => obstacle.gravity()} )
		} )		
	}			
}

object predatorGenerator inherits ObjectGenerator(max = 5){
	method newPredator() = predatorFactory.buildPredator()
	method onlyPredator() = game.allVisuals().filter( {visual => visual.isPredator()} )	
	method generate() {
//		max = 5
		if(self.haveToGenerate()) {
			const newPredator = self.newPredator()
			game.addVisual(newPredator)
			genObjects.add(newPredator)
		}
	}
	override method show(){
		super()
		game.onTick(5500, "PREDATOR", { self.generate() })
		game.onTick(550, "PREDATORGRAVITY", { 
			genObjects.forEach( { predator => predator.gravity()} )
		} )		
	}			
}