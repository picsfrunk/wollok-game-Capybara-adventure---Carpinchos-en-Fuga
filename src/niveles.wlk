import wollok.game.* 
import objects.*
import capybara.*
import enemies.* 
import randomizer.*

class Nivel {
	var property nivel = 0
	method image() = "fondo_nivel" + self.nivel().toString() + ".jpg"
	method terminar() {
		game.schedule(3000, {game.stop()})
	}
	method cargar() {
		game.boardGround(self.image())
		game.addVisual(capybara)
		
		keyboard.left().onPressDo(  { capybara.mover(izquierda) } )
		keyboard.right().onPressDo(  { capybara.mover(derecha) } )	
		keyboard.up().onPressDo( { capybara.mover(arriba) } )
		game.onTick(800, "GRAVEDAD", { capybara.gravedad()})			
	}	
}
object nivel1 inherits Nivel {
	override method cargar() {
		self.nivel(1)
		super()
//		game.onTick(800, "HUMANOS", { capybara.gravedad()})
	}
	
	
	}	
object nivel2 inherits Nivel{
	
	override method cargar() {
		self.nivel(2)
		super()
	}	

}
object nivel3 inherits Nivel{
	override method cargar() {
		self.nivel(3)
		super()
	}	

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