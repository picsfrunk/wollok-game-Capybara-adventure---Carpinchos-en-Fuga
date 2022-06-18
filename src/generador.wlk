import enemies.*
import randomizer.*
import wollok.game.* 
import objects.*
import sonido.*
import niveles.*

class Factory {
	method random() = randomizer.emptyPosition()
	method randomLeft() = randomizer.emptyPositionLeft()
	method build()
	
}
object humanFactory inherits Factory{
	//const suf = [1,2,3]
	override method build()= nivelActual.humans() //new Human(sufijo=suf.anyOne(), position=self.random())
}
object predatorFactory inherits Factory{
	const suf = [1,2]
	override method build() = new Predator(sufijo=suf.anyOne(), position=self.randomLeft())
}
object beerFactory inherits Factory{
	override method build() = new Beer(position=self.random())
}
object tequilaFactory inherits Factory{
	override method build() = new Tequila(position=self.random())
}
object birkirFactory inherits Factory{
	override method build() = new Birkir(position=self.random())
}
object keyFactory inherits Factory {
	override method build() = new Llave(position=self.random())
}
object obstacleFactory inherits Factory { //otra opción: hacer una factory x obstáculo y tratarlo como las botellas

	override method build() = //new Wall(position=self.random())
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
	var property timeGravity = nivelActual.is().initTimeGravity()
	var property timeTickGen = nivelActual.is().initTimeGenerator()
	const timeGravityMax = 300
	method enemiesGenerator() //aqui colocar el objeto generador
	method generate() {
		
//		console.println("Human Generator" + timeHumanTickGen)
		if(self.haveToGenerate()) {
			const newEnemy = self.enemiesGenerator().build()
			game.addVisual(newEnemy)
			genObjects.add(newEnemy)
		}
	}
	

	method onTickGenerator(){
		game.onTick(timeTickGen, self.enemiesGenerator().toString(), { self.generate()  })	 		
	}
	method gravityOn(){
		game.onTick(timeGravity, self.enemiesGenerator().toString() + "gravity", { 
			genObjects.forEach( { obj => obj.gravity()} )
		} )				
	}
	override method show(){
//		self.resetColection()
		super()
		self.onTickGenerator()
		self.gravityOn()
	}
	method upTimeGravity(n){ //ver la manera de limitar despues
		if (timeGravity < timeGravityMax){
			timeTickGen = timeTickGen - (n+200) //pruebas
			timeGravity = timeGravity - n
			self.refresh()			
		}
	}	
	method downTimeGravity(n){
		if (timeGravity < timeGravityMax){
			timeTickGen = timeTickGen + (n+200) //pruebas
			timeGravity = timeGravity + n
			self.refresh()			
		}
	}
	method refreshGravity(){
		game.removeTickEvent(self.enemiesGenerator().toString() + "gravity")
		game.onTick(timeGravity, self.enemiesGenerator().toString() + "gravity", { 
			genObjects.forEach( { obj => obj.gravity()} )
		} )		
	}
	method refreshTick(){
		game.removeTickEvent(self.enemiesGenerator().toString()) //pruebas
		self.onTickGenerator()
	}
	method refresh(){
		self.refreshGravity()
		self.refreshTick()
	}
}

object humanGenerator inherits EnemiesGenerator (max = 6){
	override method enemiesGenerator() = humanFactory
	
}

object predatorGenerator inherits EnemiesGenerator (max = 5){
	override method enemiesGenerator() = predatorFactory
	
}


object bottleGenerator inherits ObjectGenerator (max = 3){
	const factories = [beerFactory, tequilaFactory, birkirFactory]
	method newBottle() = factories.anyOne().build()
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
	method newKey() = keyFactory.build()
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
	method newObstacle() = obstacleFactory.build()
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

