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
		const newLife = life - damage
		if (newLife < 0 )
			self.lose()
		else
			life = newLife
		display.write(self.life().toString()) //sacar o cambiar despues de poner barrita de vida y hacer directamente metodo para eso
	}
	method winLives(won){
		const newLife = life + won
		if (newLife > maxLife )
			life = maxLife
		else
			life = newLife
		display.write(self.life().toString()) //sacar o cambiar despues de poner barrita de vida y hacer directamente metodo para eso
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
		keys.add(key)
		display2.write(self.keyscount().toString())	// solo para pruebas	
		if (self.keyscount() == keysForWin)	
			self.levelUp()			
	}
	method keyscount() = keys.size()
	method lose(){
		pantallaFinal.perder()
	}
	method win(){
		pantallaFinal.ganar()
	}
	method levelUp(){
		if ( nivel1.enCurso() )
			nivel1.terminar()
		if ( nivel2.enCurso() )
			nivel2.terminar()			
		if ( nivel3.enCurso() )
			self.win()
	}
}

