import wollok.game.* 
import objects.*
import capybara.*
import enemies.* 
import randomizer.*
import generador.*
import sonido.*

object inicio {
	var property imagen = ""
	const pantallaInicio = true
	const lvl = false
	method inicia() {
		game.addVisualIn(self, game.center())
		game.schedule(500, {pantallaInicial.iniciar()})
	}
}
object pantallaInicial {
	var property image = ""
	const pantallaInicio = true
	const lvl = false
	method siguiente() = nivel1
	method enterParaJugar() {
		keyboard.enter().onPressDo({ pantallaInicial.finalizar()})
	}
	method finalizar() {
		game.clear() 
		self.siguiente().iniciar()
	}
	method iniciar() {
		game.addVisualIn(self, game.center())
		musicaInicial.play()
		configuracion.musicaOnOff()
		game.schedule(5000, {image="instrucciones.png"})
		self.enterParaJugar()
	
	}
}
class Nivel {
	const pantallaInicio = false
	const lvl = true
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
