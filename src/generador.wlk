import enemies.*
import randomizer.*
import wollok.game.* 
import objects.*
import sonido.*
import niveles.*

class Factory {
	method random() = randomizer.emptyPosition()
}
object humanFactory inherits Factory{
	const suf = [1,2,3]
	method buildHuman() = new Human(sufijo=suf.anyOne(),position=self.random())
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
class ObjectGenerator {
	var property max = 0
	const genObjects = []
	method borrar(obj) {
		genObjects.remove(obj)
	}
	method haveToGenerate() = genObjects.size() <= max
	
}
object humanGenerator inherits ObjectGenerator {
	var property timeHumanGravity = nivel1.initTimeHumanGravity()
	var property timeHumanTickGen = nivel1.initTimeHumanGenerator()
	method generate() {
		max = 6
		if(self.haveToGenerate()) {
			const newHuman = humanFactory.buildHuman()
			game.addVisual(newHuman)
			genObjects.add(newHuman)
		}
	}
	method onlyEnemies() =
		game.allVisuals().filter( {visual => visual.isEnemy()} )
	method onTickGenerator(){
		game.onTick(timeHumanTickGen, "HUMANS", { self.generate() })	 		
	}
	method gravityOn(){
		game.onTick(timeHumanGravity, "HUMANGRAVITY", { 
			self.onlyEnemies()
			.forEach( { enemy => enemy.gravity()} )
		} )				
	}
	method show(){
		self.onTickGenerator()
		self.gravityOn()
	}
	method upTimeHumanGravity(n){ //ver la manera de limitar despues
		timeHumanTickGen = timeHumanTickGen - (n+200) //pruebas
		timeHumanGravity = timeHumanGravity - n
		self.refresh()
	}	
	method downTimeHumanGravity(n){
		timeHumanTickGen = timeHumanTickGen + (n+200)	//pruebas
		timeHumanGravity = timeHumanGravity + n
		self.refresh()
	}
	method refreshGravity(){
		display.write(timeHumanGravity.toString())
		game.removeTickEvent("HUMANGRAVITY")
		game.onTick(timeHumanGravity, "HUMANGRAVITY", { 
			self.onlyEnemies()
			.forEach( { enemy => enemy.gravity()} )
		} )		
	}
	method refreshTick(){
		display2.write(timeHumanTickGen.toString())
		game.removeTickEvent("HUMANS") //pruebas
		self.onTickGenerator()
	}
	method refresh(){
		self.refreshGravity()
		self.refreshTick()
	}
}
object bottleGenerator inherits ObjectGenerator {
	const factories = [beerFactory, tequilaFactory, birkirFactory]
	method newBottle() = factories.anyOne().buildBottle()
	method onlyBottles() = 
		game.allVisuals().filter( {visual => visual.isBottle()} )		
	method generate() {
		max = 3
		if(self.haveToGenerate()) {
			const newBottle = self.newBottle()
			game.addVisual(newBottle)
			genObjects.add(newBottle)
		}
	}
	method show(){
		game.onTick(5000, "BOTTLES", { self.generate() })
		game.onTick(500, "BOTTLESGRAVITY", { 
			self.onlyBottles()
			.forEach( { bottle => bottle.gravity()} )
		} )		
	}	
}

