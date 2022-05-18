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
		keyboard.enter().onPressDo({ self.finalizar()})
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
	method siguiente() = "nivel" + (self.nivel()+1).toString()
	method image() = "fondo_nivel" + self.nivel().toString() + ".jpg"
	method iniciar() {
		game.addVisualIn(self, game.center())
		game.schedule(1000, { game.clear()
			self.cargar()
		})
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
	method terminar() {
		game.schedule(100, { game.clear() })
		game.clear() 
		game.schedule(500, { self.siguiente().iniciar()})
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
object pantallaFinal {
	var property image
	method ganar() {
		image = "ganaste.png"
		sonidoGanar.play()
		self.final()
	}
	method perder() {
		image = "gameOver.png"
	    sonidoPerder.play()
		self.final()
	}
	method enterParaFin(){
		keyboard.enter().onPressDo({ game.stop()})
	}
	method final() {
		game.clear()
		game.addVisualIn(self, game.at(0, 0))
		self.enterParaFin()
		sonidoMusica.stop()
	}
	
}
