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
		self.pista().play()
		self.enterParaJugar()
	}
}
object pantallaInicial1 inherits PantallaInicial 
	(image = "comandos.png", pista = pistaInicial, siguiente = pantallaInicial2) {
}
object pantallaInicial2 inherits PantallaInicial
	(image = "amigosenemigos.jpg", pista = pistaInicial, siguiente = pantalla1){
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
	method prefinal() {
		game.clear()
		game.addVisual(fade)
		game.onTick(1000, "CONTEOINVERSO" , {fade.countBackwards()})
		game.schedule(2000,{self.final()})	
	}
	method final() {
		game.addVisualIn(self, game.at(0, 0))
		self.enterParaFin()
		game.schedule(15000, {game.stop()})	
	}
	method finalizar(){
		self.pista().play()
		self.final()
	}
}
object pantallaGanar inherits PantallaFinal (image = "ganaste.png",pista = sonidoGanar){
}
object pantallaPerder inherits PantallaFinal (image = "perdiste.png",pista = sonidoPerder){
}

class PantallaNivel {
	var property image
	
	method iniciar() {
		game.clear()
		game.addVisualIn(self, game.at(0,0))
	}	
}
object pantalla1 inherits PantallaNivel (image = "nivel1.png") {
	override method iniciar() {
		super()
		game.schedule(1000, { game.clear()
			nivel1.cargar()
		})	
	}
}
object pantalla2 inherits PantallaNivel (image = "nivel2.png"){
	override method iniciar() {
		super()
		game.schedule(1000, { game.clear()
			nivel2.cargar()
		})	
	}
}
object pantalla3 inherits PantallaNivel (image = "nivel3.png"){
	override method iniciar() {
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
	var property imagenInicioNivel
	const property generators = #{}
	const property exit
	
	method showExit(){
		const exitImage = new Exit()
		const exitInvisible = new InvisibleExit()
		exitImage.show()
		exitInvisible.show()
	}
	method initTimeGenerator()
	method initTimeGravity()
	method acelerar(timeUp){
//		console.println("Up timeGravity en Nivel " + nivel.toString())
//		humanGenerator.upTimeGravity(timeUp)
		generators.forEach( { gen => gen.upTimeGravity(timeUp) } )
	}
	method desacelerar(timeDown){
//		console.println("Down timeGravity en Nivel " + nivel.toString())
//		humanGenerator.downTimeGravity(timeDown)
		generators.forEach( { gen => gen.downTimeGravity(timeDown) } )
	}	
//	method exitImagePosition(){
//		return game.at(game.width() - 1,0)
//	}
	method addGenerators(){
		generators.addAll(#{bottleGenerator,obstacleGenerator,keyGenerator})
	} 
	method initVisualsGenerators(){
		generators.clear()
		self.addGenerators()		
		generators.forEach( { gen => gen.show() } )
	}
	method terminar() {
		game.removeVisual(time)
		game.removeVisual(hp)
		game.removeVisual(keychain)
		self.pista().stop()	
		enCurso = false
	}
	method cargar() {
		enCurso = true
		game.clear()
		game.addVisualIn(self, game.at(0,0))
		game.addVisual(capybara)
		game.errorReporter(capybara)	
		game.addVisual(hp)
		time.resetCounter()
		game.addVisual(time)
		game.addVisual(keychain)
		capybara.resetKeys()
		keyboard.left().onPressDo(  { capybara.mover(izquierda) } )
		keyboard.right().onPressDo(  { capybara.mover(derecha) } )	
		keyboard.up().onPressDo( { capybara.mover(arriba) } )
		keyboard.down().onPressDo( { capybara.mover(abajo) } )
		self.pista().play()
		musicConfig.musicaOnOff(self.pista())
		game.onCollideDo(capybara, { someone => someone.crash(capybara) } )
		game.schedule(60000, { capybara.timeOver() })
		game.onTick(1000, "CONTEOINVERSO" , {time.countBackwards()})
		self.initVisualsGenerators()
	}	
	method iniciar () {
		game.addVisualIn(imagenInicioNivel, game.at(0,0))
		game.schedule(1000, { game.clear()
			self.cargar()
		})
	}
	method obstacles()
}
object nivel1 inherits Nivel(image ="fondo_nivel1.jpg", nivel = 1, pista = musicaNivel1, 
						     imagenInicioNivel  = "nivel1.png", exit = "wallcrack.png") {
	override method cargar() {
		capybara.keysForWin(2)	//configurar antes de entrega	
		super()
	}
	override method terminar(){
		super()
		pantalla2.iniciar()
		game.schedule(3000, { nivel2.cargar()})
	}	
	
	override method initTimeGenerator() = 2000
	override method initTimeGravity() = 700
	override method addGenerators(){
		super()
		generators.add(humanGenerator)
	} 	
	override method obstacles() = new Wall(position=randomizer.emptyPosition())		
	
}		
object nivel2 inherits Nivel (image ="fondo_nivel2.jpg",nivel = 2, pista = musicaNivel2, 
							  imagenInicioNivel = "nivel2.png", exit = "fencecrack.png"){
	
	override method cargar() {
		capybara.keysForWin(2) //configurar antes de entrega
		super()
	}	
	override method terminar(){
		super()
		pantalla3.iniciar()
		game.schedule(3000, { nivel3.cargar()})
	}	
	override method addGenerators(){
		super()
		generators.add(animalControlGenerator)
	} 		
	override method initTimeGenerator() = 1800
	override method initTimeGravity() = 600
	override method obstacles() = new Fence(sufijo=[1,2].anyOne(),position=randomizer.emptyPosition())	
}
object nivel3 inherits Nivel (image ="fondo_nivel3.jpg",nivel = 3, pista = musicaNivel3, 
					          imagenInicioNivel = "nivel3.png", exit = "burrow.png"){
	override method cargar() {
		super()
		capybara.keysForWin(2) //configurar antes de entrega
	}
	override method terminar() {}	
	override method initTimeGenerator() = 1600
	override method initTimeGravity() = 500	
	override method addGenerators(){
		super()
		generators.addAll(#{predatorGenerator,swimmerGenerator})
	} 	
	override method obstacles() = new Stump(sufijo=[1,2,3].anyOne(),position=randomizer.emptyPosition())
}

object nivelActual {
	method is() =
		if (nivel1.enCurso()) 
			nivel1
		else
		if (nivel2.enCurso()) 
			nivel2
		else  
			nivel3				
}

