import enemies.*
import randomizer.*
import wollok.game.* 
import objects.*

object humanFactory {
	const rango = [1,2,3]
	method buildHuman() = new Human(sufijo=rango.anyOne(),position=randomizer.emptyPosition())
}
object beerFactory {
	method buildBottle() = new Beer(position=randomizer.emptyPosition())
}
object tequilaFactory {
	method buildBottle() = new Tequila(position=randomizer.emptyPosition())
}
object birkirFactory {
	method buildBottle() = new Birkir(position=randomizer.emptyPosition())
}
class ObjectGenerator {
	const max = 6
	const objetosGenerados = []
	method borrar(obj) {
		objetosGenerados.remove(obj)
	}
	method hayQueGenerar() = objetosGenerados.size() <= max
	
}
object humanGenerator inherits ObjectGenerator {

	method generar() {
		if(self.hayQueGenerar()) {
			const nuevo = humanFactory.buildHuman()
			game.addVisual(nuevo)
			objetosGenerados.add(nuevo)
		}
	}
	method show(){
		game.onTick(3000, "HUMANS", { self.generar() })
		game.onTick(800, "HUMANGRAVITY", { game.allVisuals().filter( {visual => visual.isEnemy()} ).forEach( { enemy => enemy.gravedad()} ) } )		
	}
}
object bottleGenerator inherits ObjectGenerator {
	const factories = [beerFactory, tequilaFactory, birkirFactory]
	method newBottle() = factories.anyOne().buildBottle()
	method generar() {
		if(self.hayQueGenerar()) {
			const nuevo = self.newBottle()
			game.addVisual(nuevo)
			objetosGenerados.add(nuevo)
		}
	}
	method show(){
		game.onTick(4000, "BOTTLES", { self.generar() })
		game.onTick(1000, "BOTTLESGRAVITY", { game.allVisuals().filter( {visual => visual.isBottle()} ).forEach( { bottle => bottle.gravedad()} ) } )		
	}	
}

