import wollok.game.* 
import objects.*
import capybara.*
import enemies.* 
import randomizer.*
import generador.*
import sonido.*

object inicio {
	var property image = "start.png"
	method iniciar() {	
		game.schedule(2000, {pantallaInicial1.iniciar()})
	}
}
class PantallaInicial {
	var property image
	var property pista
	var property siguiente
	method enterParaJugar() {
		keyboard.enter().onPressDo({ self.finalizar() })
	}
	method finalizar() {
		game.clear() 
		self.siguiente().iniciar()
	}
	method iniciar() {
		game.addVisualIn(self, game.at(0,0))
		musicConfig.musicaOnOff(self.pista())
		self.enterParaJugar()
	}
}
object pantallaInicial1 inherits PantallaInicial 
	(image = "comandos.png", pista = pistaInicial, siguiente = pantallaInicial2) {
	override method iniciar() {
		super()
		self.pista().play()
		self.enterParaJugar()
	}
}
object pantallaInicial2 inherits PantallaInicial
	(image = "amigosenemigos.jpg", pista = pistaInicial, siguiente = nivel1){
	override method finalizar() {
		super()
		self.pista().stop()
	}
}
class PantallaFinal {
	var property image
	var property pista
	method enterParaFin(){
		keyboard.enter().onPressDo({ game.stop()}) }
	method final() {
		game.clear()
		game.addVisualIn(self, game.at(0, 0))
		self.enterParaFin()
		game.schedule(10000, {game.stop()})
	}
	method finalizar(){
		self.pista().play()
		self.final()
		//self.pista().stop()
	}
}
object pantallaGanar inherits PantallaFinal (image = "ganaste.png",pista = sonidoGanar){
}
object pantallaPerder inherits PantallaFinal (image = "perdiste.png",pista = sonidoPerder){
}
class PantallaNivel {
	var property image
	method iniciarpantalla() {
		game.clear()
		game.addVisualIn(self, game.at(0,0))
	}	
}
object pantalla1 inherits PantallaNivel (image = "nivel1.png") {
	override method iniciarpantalla() {
		super()
		game.schedule(1000, { game.clear()
			nivel1.cargar()
		})	
	}
}
object pantalla2 inherits PantallaNivel (image = "nivel2.png"){
	override method iniciarpantalla() {
		super()
		game.schedule(1000, { game.clear()
			nivel2.cargar()
		})	
	}
}
object pantalla3 inherits PantallaNivel (image = "nivel3.png"){
	override method iniciarpantalla() {
		super()
		game.schedule(1000, { game.clear()
			nivel3.cargar()
		})	
	}
}
class Nivel inherits DefaultObjects {
	var property nivel
	var property enCurso = false
	var property pista
	var property image
	
	method terminar() {
		enCurso = false
		self.pista().stop()	
		if (nivel3.enCurso())
			game.say(capybara, "GANASTE!!!")	
		else
			game.say(capybara, "PASASTE DE NIVEL!!!")	
//		game.schedule(2000, { game.clear() }) // CUANDO DEJABA ESTO BORRABA TODO Y NO CARGABA EL NIVEL SIGUIENTE
	}
	method cargar() {
		enCurso = true
		game.clear()
		game.addVisualIn(self, game.at(0,0))
		game.addVisual(capybara)
		game.errorReporter(capybara)	
		game.addVisual(display)
		game.addVisual(display2)
		game.addVisual(display3)
		display.write(capybara.life().toString())
		display2.write(capybara.keyscount().toString())	// solo para pruebas			
		display3.write(nivelActual.is().toString())
		keyboard.left().onPressDo(  { capybara.mover(izquierda) } )
		keyboard.right().onPressDo(  { capybara.mover(derecha) } )	
		keyboard.up().onPressDo( { capybara.mover(arriba) } )
		keyboard.down().onPressDo( { capybara.mover(abajo) } )
		capybara.resetKeys()
		self.pista().play()
		musicConfig.musicaOnOff(self.pista())
		humanGenerator.show()
		bottleGenerator.show()
		keyGenerator.show()
		obstacleGenerator.show()
		game.onCollideDo(capybara, { someone => someone.crash(capybara) })
		game.schedule(60000, { capybara.lose() })
		
	}	
}
object nivel1 inherits Nivel(image ="fondo_nivel1.jpg", nivel = 1, pista = musicaNivel1) {
	var property initTimeHumanGenerator = 2000 
	var property initTimeHumanGravity = 700
	var property imagenInicioNivel = "nivel1.png"
	
	method iniciar () {
		pantalla1.iniciarpantalla()
	}
	override method cargar() {
		capybara.keysForWin(2)		
		super()
	}
	override method terminar(){
		super()
		pantalla2.iniciarpantalla()
		game.schedule(3000, { nivel2.cargar()})
	}	
}		
object nivel2 inherits Nivel (image ="fondo_nivel2.jpg",nivel = 2, pista = musicaNivel2){
	var property imagenInicioNivel = "nivel2.png"
	method iniciar () {
		game.addVisualIn(imagenInicioNivel, game.at(0,0))
		game.schedule(1000, { game.clear()
			self.cargar()
		})
	}
	override method cargar() {
		capybara.keysForWin(2)
		super()
	}	
	override method terminar(){
		super()
		pantalla3.iniciarpantalla()
		game.schedule(3000, { nivel3.cargar()})
//		enCurso = false
	}	
}
object nivel3 inherits Nivel (image ="fondo_nivel3.jpg",nivel = 3, pista = musicaNivel3){

	var property imagenInicioNivel = "nivel3.png"
	method iniciar () {
		game.addVisualIn(imagenInicioNivel, game.at(0,0))
		game.schedule(1000, { game.clear()
			self.cargar()
		})
	}
	override method cargar() {
		capybara.keysForWin(2)
		super()
	}
	override method terminar() {}		
}
object nivelActual {
	const suf3 = [1,2,3]
	const suf2 = [1,2]	
	
	method random() = randomizer.emptyPosition()	
	method obstacles() =
		if (nivel1.enCurso()) 
			new Wall(position=self.random())
		else
		if (nivel2.enCurso()) 
			new Fence(sufijo=suf2.anyOne(),position=self.random())
		else  
			new Stump(sufijo=suf3.anyOne(),position=self.random())

	method humans() = 	
	
		if (nivel1.enCurso()) new Human (sufijo=suf3.anyOne(), position=self.random())
		else
		if (nivel2.enCurso()) new AnimalControl(sufijo=suf3.anyOne(),position=self.random())
		else  
		if (nivel3.enCurso()) new Swimmer(sufijo=suf2.anyOne(),position=self.random())
		else null			

	method is() =
		if (nivel1.enCurso()) 
			nivel1
		else
		if (nivel2.enCurso()) 
			nivel2
		else  
			nivel3
	
					
		
}