import wollok.game.* 
import objects.*
import capybara.*
import enemies.* 

class Nivel {
	var property nivel = 0
	const property atravesable = true
	
	method image() = "fondo_nivel" + self.nivel() + ".jpg"
	
	method terminar() {
		game.schedule(3000, {game.stop()})
	}
	
	
}


object nivel1 inherits Nivel {
	
	
	method cargar() {
		self.nivel(1)
		game.boardGround(self.image())
		game.addVisual(capybara)
		
		keyboard.left().onPressDo(  { capybara.mover(izquierda) } )
		keyboard.right().onPressDo(  { capybara.mover(derecha) } )	
		keyboard.up().onPressDo( { capybara.mover(arriba) } )
		game.onTick(500, "GRAVEDAD", { capybara.gravedad()})			
	}
	
	
}

object nivel2 inherits Nivel{
	
	
}


object nivel3 inherits Nivel{
	
	
}



object validador {
	method validarPosition(position) {
		if (! position.x().between(0, game.width() -1)){
			self.error("!!!!")
		}	
		if(! position.y().between(0, game.height() - 1)) {
			self.error("!")
		}		
		
	}
}
