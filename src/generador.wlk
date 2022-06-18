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
			const newObject = self.objToFactory().build()
			game.addVisual(newObject)
			genObjects.add(newObject)
		}
	}
	method applyGravityAllColection(){
		genObjects.forEach( { obj => obj.gravity() } )
	}	

	method onTickGenerator(){
		game.onTick(timeTickGen, nameOnTickGenerator, { self.generate()  })
	}
	method gravityOn(){
		game.onTick(timeGravity, nameGravityOn, {self.applyGravityAllColection()} ) 		
//		console.println("Gravity to "+timeGravity+" Name "+ nameGravityOn)	
	}
	override method show(){
//		self.resetColection()
		super()
		nameOnTickGenerator	= self.objToFactory().toString()
		nameGravityOn = self.objToFactory().toString() + "Gravity"		
		self.onTickGenerator()
		self.gravityOn()
//		console.println("Init TimeGravity: "+timeGravity+" Init timeTickGen: "+timeTickGen)		
	}
	method upTimeGravity(n){ //subir la gravedad es bajar el tiempo
		const newtimeGravity = timeGravity - n
		if (! (newtimeGravity < timeGravityMax)){
			timeTickGen = timeTickGen - n*1.2
			timeGravity = newtimeGravity
			self.refresh()	
//			.println("Up TimeGravity: "+timeGravity+"\n"+"Up timeTickGen: "+timeTickGen+"\n")
		}
		
//			console.println("Not modified")
		
	}	
	method downTimeGravity(n){ //bajar la gravedad es aumentar el tiempo de tickGen y Gravedad
		timeTickGen = timeTickGen + n*1.2
		timeGravity = timeGravity + n
		self.refresh()						
//		console.println("Down TimeGravity: "+timeGravity+"\n"+"Down timeTickGen: "+timeTickGen+"\n")			
	}
	method refreshGravity(){
		game.removeTickEvent(nameGravityOn)
//		console.println("Removed TickEvent refreshGravity(): "+nameGravityOn)
		self.gravityOn()	
	}
	method refreshTickGenerator(){
		game.removeTickEvent(nameOnTickGenerator) 
//		console.println("Removed TickEvent refreshTick(): "+nameOnTickGenerator)
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

