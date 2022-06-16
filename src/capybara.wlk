import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*
import sonido.*
import generador.*

object capybara inherits objects.DefaultObjects {
	var property position = game.at(game.width().div(2)-1,0)
	var property sufijo = "inicial"
	var property life = 100
	var property nextPosition = game.at(0,0)
	var property keys = []
	var property keysForWin = 0
	const maxLife = 100
	//agregar limite de cero para perder
	method image() = "capy_" + self.sufijo() + ".png"		
	method mover(direccion) {
		nextPosition = direccion.siguiente(position)
		self.validarPosition(nextPosition)
		self.sufijo(direccion.toString())
		if (direccion.equals(arriba))
			game.schedule(1000, { self.mover(abajo) })
		position = nextPosition		
	}
	method validarPosition(_nextPosition) {
		if (   (_nextPosition.x() == 0) 
			or (_nextPosition.x() == game.width() - 1) 
			or (! self.puedeSaltar(_nextPosition) )
			or  (_nextPosition.y() == 2) 
			or (_nextPosition.y() < 0)
			) 
			nextPosition = position	
	}	
	method puedeSaltar(_position) {
		return 	game.getObjectsIn(_position).
				all({visual => ! visual.isObstacle() } )	
	}		
	method loseLives(damage){
		game.removeVisual(hp)
		const newLife = life - damage
		if (newLife < 0 )
			self.lose()
		else
			life = newLife
		display.write(self.life().toString()) //sacar o cambiar despues de poner barrita de vida y hacer directamente metodo para eso
		game.addVisual(hp)
	}
	method winLives(won){
		game.removeVisual(hp)
		const newLife = life + won
		if (newLife > maxLife )
			life = maxLife
		else
			life = newLife
		display.write(self.life().toString()) //sacar o cambiar despues de poner barrita de vida y hacer directamente metodo para eso
		game.addVisual(hp)
	}
	method drinkBottle(bottle){
		bottle.taken(self)
	}
	method acelerate(timeUp){
		humanGenerator.upTimeHumanGravity(timeUp)
	}
	method decelerate(timeDown){
		humanGenerator.downTimeHumanGravity(timeDown)		
	}
	method shock(){
		sufijo = "shock"
	}
	
	method addKey(key){
		game.removeVisual(keychain)
		keys.add(key)
		display2.write(self.keyscount().toString())	// solo para pruebas	
		if (self.keyscount() == keysForWin)
			nivelActual.is().showExit()
//			self.levelUp()	
		game.addVisual(keychain)		
	}
	method keyscount() = keys.size()
	method resetKeys(){
		keys.clear()
	}
	method lose(){
		game.addVisual(fade)
		game.removeVisual(hp)
		pantallaPerder.finalizar()
	}
	method win() {
		game.addVisual(fade)
		game.removeVisual(hp)
		pantallaGanar.finalizar()
	}
	method timeOver(){
		game.say(self,"SE AGOTO EL TIEMPO!!")
		game.schedule(2000,{ (nivelActual.is()).pista().stop()
			self.lose()
		})
	}
	method levelUp(){
		if (nivel3.enCurso()) { (nivelActual.is()).pista().stop()
			self.win()
		}
		else {nivelActual.is().terminar()}	
	}
}

