import wollok.game.* 
import objects.*
import capybara.*
import enemies.* 
import randomizer.*
import generador.*
import sonido.*

object inicio {
	var property image = "start.jpg"
//	const property pantallaInicio = true
//	const property lvl = false
	method iniciar() {
		game.addVisualIn(self, game.at(0,0))
//		musicaInicial.play()
//		musicConfig.musicaOnOff()		
		game.schedule(2000, {pantallaInicial.iniciar()})
	}
}
object pantallaInicial {
	var property image = "comandos.jpg"
	var property pista = pistaInicial
//	const pantallaInicio = true
//	const lvl = false
	var property siguiente = nivel1
	method enterParaJugar() {
		keyboard.enter().onPressDo({ self.finalizar() })
	}
	method finalizar() {
		game.clear() 
		self.pista().stop()
		self.siguiente().cargar()
	}
	method iniciar() {
		game.addVisualIn(self, game.at(0,0))
		self.pista().play()
		musicConfig.musicaOnOff(self.pista())
//		game.schedule(5000, {image="instrucciones.png"})
		self.enterParaJugar()
	}
}
class Nivel inherits DefaultObjects {
	var property nivel = 1
	var property enCurso = false
	var property image = "fondo_nivel" + nivel.toString() + ".jpg"
	var property pista = pistaInicial
	method terminar() {
		enCurso = false
		self.pista().stop()
		game.schedule(3000, {game.stop()})
	}
	method cargar() {
		game.addVisualIn(self, game.at(0,0))
//		game.boardGround(image.toString())
		game.addVisual(capybara)
		game.errorReporter(capybara)	
		game.addVisual(display)
		game.addVisual(display2)
		display.write(humanGenerator.timeHumanGravity().toString())		// solo para pruebas
		display2.write(humanGenerator.timeHumanTickGen().toString())	// solo para pruebas			
		keyboard.left().onPressDo(  { capybara.mover(izquierda) } )
		keyboard.right().onPressDo(  { capybara.mover(derecha) } )	
		keyboard.up().onPressDo( { capybara.mover(arriba) } )
		keyboard.down().onPressDo( { capybara.mover(abajo) } )
		game.onCollideDo(capybara, { someone => someone.crash(capybara) })
		game.schedule(60000, { capybara.lose() })
		self.pista().play()
		musicConfig.musicaOnOff(self.pista())
		
	}	
}
object nivel1 inherits Nivel {
	var property initTimeHumanGenerator = 2000 
	var property initTimeHumanGravity = 700
	var property imagenNivel = "nivel1.jpg"
	override method cargar() {
		enCurso = true
		pista = musicaNivel1
		self.nivel(1)
		super()
		humanGenerator.show()
		bottleGenerator.show()
	}

	
	
	}	
object nivel2 inherits Nivel{
	
	override method cargar() {
		enCurso = true		
		pista = musicaNivel2	
		self.nivel(2)
		super()
	}	

}
object nivel3 inherits Nivel{
	override method cargar() {
		enCurso = true		
		pista = musicaNivel2	
		self.nivel(3)
		super()
	}	

}
