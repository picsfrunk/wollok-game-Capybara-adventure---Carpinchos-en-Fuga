import enemies.*
import randomizer.*
import wollok.game.* 
import objects.*
import sonido.*
import niveles.*

class Factory {
	const property suf2 = (1 .. 2)
	const property suf3 = (1 .. 3)
	method random() = randomizer.emptyPosition()
	method randomLeft() = randomizer.emptyPositionLeft()
	method randomRight() = randomizer.emptyPositionRight()
	method build()
	
}
object humanFactory inherits Factory{
	//const suf = [1,2,3]
	override method build()= new Human (sufijo=suf3.anyOne(), position=self.random()) //new Human(sufijo=suf.anyOne(), position=self.random())
}
object animalControlFactory inherits Factory{
	
	override method build()= new AnimalControl(sufijo=suf3.anyOne(),position=self.random())
}
object swimmerFactory inherits Factory{
	
	override method build() = new Swimmer(sufijo=suf2.anyOne(),position=self.randomRight())
}
object predatorFactory inherits Factory{
	
	override method build() = new Predator(sufijo=suf2.anyOne(), position=self.randomLeft())
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

class ObjGeneratorWithGravity inherits ObjectGenerator {
	var property timeGravity = 0
	var property timeTickGen = 0
	var property nameOnTickGenerator = 0
	var property nameGravityOn = 0
	const timeGravityMax = 100
	
	//metodo generico para colocar el objeto generador, debe entender el method build()
	method objToFactory() 
	
	method generate() {
		if(self.haveToGenerate()) {
			const newEnemy = self.objToFactory().build()
			game.addVisual(newEnemy)
			genObjects.add(newEnemy)
		}
	}
	method applyGravityAllColection(){
		genObjects.forEach( { obj => obj.gravity() } )
	}

	method onTickGenerator(){
		game.onTick(timeTickGen, nameOnTickGenerator, { self.generate()  })
//		console.println("OnTick generator to "+timeTickGen+" Name "+nameOnTickGenerator)	
		 		
	}
	method gravityOn(){
		game.onTick(timeGravity, nameGravityOn, {self.applyGravityAllColection()} ) 		
//		console.println("Gravity to "+timeGravity+" Name "+ nameGravityOn)	
	}
	override method show(){
		super()
	
		nameOnTickGenerator	= self.objToFactory().toString()
		nameGravityOn = self.objToFactory().toString() + "Gravity"
		self.onTickGenerator()
		self.gravityOn()
		console.println("Init TimeGravity: "+timeGravity+" Init timeTickGen: "+timeTickGen)
	}
	method upTimeGravity(n){ //subir la gravedad es bajar el tiempo
		const newtimeGravity = timeGravity - n
		if (! (newtimeGravity < timeGravityMax)){
			timeTickGen = timeTickGen - n*1.2
			timeGravity = newtimeGravity
			self.refresh()			
			console.println("Up TimeGravity: "+timeGravity+"\n"+"Up timeTickGen: "+timeTickGen+"\n")
		}
		else
			console.println("Don't modified")
			
	}	
	method downTimeGravity(n){ //bajar la gravedad es aumentar el tiempo de tickGen y Gravedad
		timeTickGen = timeTickGen + n*1.2
		timeGravity = timeGravity + n
		self.refresh()						
		console.println("Down TimeGravity: "+timeGravity+"\n"+"Down timeTickGen: "+timeTickGen+"\n")			
	
			
	}
	method refreshGravity(){
		game.removeTickEvent(nameGravityOn)
		console.println("Removed TickEvent refreshGravity(): "+nameGravityOn)
		self.gravityOn()
	}
	method refreshTickGenerator(){
		game.removeTickEvent(nameOnTickGenerator) 
		console.println("Removed TickEvent refreshTick(): "+nameOnTickGenerator)
		self.onTickGenerator()
	}
	method refresh(){
		self.refreshGravity()
		self.refreshTickGenerator()
	}
}
class EnemyGenerator inherits ObjGeneratorWithGravity{
	override method show(){
		timeGravity = nivelActual.is().initTimeGravity() 
		timeTickGen = nivelActual.is().initTimeGenerator()
		super()		
	}
}

object humanGenerator inherits EnemyGenerator (max = 6){
	override method objToFactory() = humanFactory
	
}

object animalControlGenerator inherits EnemyGenerator (max=6){
	override method objToFactory() = animalControlFactory
}

object swimmerGenerator inherits EnemyGenerator(max = 4){
	override method objToFactory() = swimmerFactory
}

object predatorGenerator inherits EnemyGenerator (max = 5){
	override method objToFactory() = predatorFactory
}

object bottleGenerator inherits ObjGeneratorWithGravity (max = 4){
	const factories = [beerFactory, tequilaFactory, birkirFactory]
	override method objToFactory() = factories.anyOne()
	override method show(){
		timeGravity = 500 
		timeTickGen = 5000	
		super()	
	}		
}

object keyGenerator inherits ObjGeneratorWithGravity (max = 1){
	override method objToFactory() = keyFactory
	
	override method show(){
		timeGravity = 500 
		timeTickGen = 7000	
		super()	
	}		
}

object obstacleGenerator inherits ObjGeneratorWithGravity (max = 5){
	override method objToFactory() = obstacleFactory
	override method show(){
		timeGravity = 600 
		timeTickGen = 6000	
		super()	
	}		
}
//object bottleGenerator inherits ObjectGenerator (max = 4){
//	const factories = [beerFactory, tequilaFactory, birkirFactory]
//	method newBottle() = factories.anyOne().build()
//	method generate() {
//		if(self.haveToGenerate()) {
//			const newBottle = self.newBottle()
//			game.addVisual(newBottle)
//			genObjects.add(newBottle)
//		}
//	}
//	override method show(){
//		super()
//		game.onTick(5000, "BOTTLES", { self.generate() })
//		game.onTick(500, "BOTTLESGRAVITY", { 
//			genObjects.forEach( { bottle => bottle.gravity()} )
//		} )		
//	}	
//}
//object keyGenerator inherits ObjectGenerator (max = 1) {
//	method newKey() = keyFactory.build()
//	method generate() {
//		if(self.haveToGenerate()) {
//			const newKey = self.newKey()
//			game.addVisual(newKey)
//			genObjects.add(newKey)
//		}
//	}
//	override method show(){
////		self.resetColection()
//		super()
//		game.onTick(8000, "KEYS", { self.generate() })
//		game.onTick(300, "KEYSGRAVITY", { 
//			genObjects.forEach( { keys => keys.gravity()} )
//		} )		
//	}				
//}
//
//object obstacleGenerator inherits ObjectGenerator (max = 5){
//	method newObstacle() = obstacleFactory.build()
//	method generate() {
////		max = 5
//		if(self.haveToGenerate()) {
//			const newObstacle = self.newObstacle()
//			game.addVisual(newObstacle)
//			genObjects.add(newObstacle)
//		}
//	}
//	override method show(){
//		super()
//		game.onTick(5500, "OBSTACLE", { self.generate() })
//		game.onTick(550, "OBSTACLEGRAVITY", { 
//			genObjects.forEach( { obstacle => obstacle.gravity()} )
//		} )		
//	}			
//}

