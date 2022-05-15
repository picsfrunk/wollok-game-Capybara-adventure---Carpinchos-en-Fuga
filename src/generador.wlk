import enemies.*
import randomizer.*
import wollok.game.* 


object humanFactory {
	method buildHuman() {
		return new Human(position=randomizer.emptyPosition())
	}	
}

object humanGenerator {
	const maximo = 6
	const objetosGenerados = []

	method generar() {
		if(self.hayQueGenerar()) {
			const nuevo = humanFactory.buildHuman()
			game.addVisual(nuevo)
			objetosGenerados.add(nuevo)
		}
	}
	
	
	
	method hayQueGenerar() {
		return objetosGenerados.size() <= maximo
	}	
}

object enemiesCreator {
	method showEnemies(){
		game.onTick(3000, "HUMANOS", { humanGenerator.generar() })
		game.onTick(1000, "HUMANGRAVITY", { game.allVisuals().filter( {visual => visual.isEnemy()} ).forEach( { enemy => enemy.gravedad()} ) } )		
	}
}