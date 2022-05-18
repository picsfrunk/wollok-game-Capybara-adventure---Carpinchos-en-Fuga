import wollok.game.* 
import objects.*
import capybara.*
import enemies.* 
import randomizer.*
import generador.*
import sonido.*

class Nivel {
	var property nivel = 0
	method image() = "fondo_nivel" + self.nivel().toString() + ".jpg"
	method terminar() {
		game.schedule(3000, {game.stop()})
	}
	method cargar() {
		game.boardGround(self.image())
		game.addVisual(capybara)
		game.errorReporter(capybara)	
		keyboard.left().onPressDo(  { capybara.mover(izquierda) } )
		keyboard.right().onPressDo(  { capybara.mover(derecha) } )	
		keyboard.up().onPressDo( { capybara.mover(arriba) } )
		game.onCollideDo(capybara, { someone => someone.crash(capybara) })
		capybara.gravityOn()
	}	
}
object nivel1 inherits Nivel {
	override method cargar() {
		self.nivel(1)
		super()
//	    game.hideAttributes(capybara)	
		
		humanGenerator.show()
		bottleGenerator.show()
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
