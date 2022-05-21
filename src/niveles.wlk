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
		game.addVisual(display)
		display.write(humanGenerator.timeHumanGravity().toString())		
		game.errorReporter(display)	
		keyboard.left().onPressDo(  { capybara.mover(izquierda) } )
		keyboard.right().onPressDo(  { capybara.mover(derecha) } )	
		keyboard.up().onPressDo( { capybara.mover(arriba) } )
		keyboard.down().onPressDo( { capybara.mover(abajo) } )
		game.onCollideDo(capybara, { someone => someone.crash(capybara) })
	}	
}
object nivel1 inherits Nivel {
	var property initTimeHumanTick = 2000 
	override method cargar() {
		self.nivel(1)
		super()
		humanGenerator.show(initTimeHumanTick)
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
