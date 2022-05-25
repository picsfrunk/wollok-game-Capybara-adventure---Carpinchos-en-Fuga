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
	}	
	
}


object nivel1 inherits Nivel {
	
	
	override method cargar() {
		self.nivel(1)
		super()
<<<<<<< Updated upstream
		game.onTick(800, "GRAVEDAD", { capybara.gravedad()})			
=======
		game.schedule(3000, { nivel2.cargar()})
//		nivel2.cargar()
		enCurso = false
//		nivel2.iniciar()
		pantalla2.iniciarpantalla()
	}	
}
object pantalla1 {
	var property image = "nivel1.jpg"
	method iniciarpantalla() {
		game.addVisualIn(self, game.at(0,0))
		game.schedule(1000, { game.clear()
			nivel1.cargar()
		})	
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
		self.enCurso(true)
		humanGenerator.show()		 
		super()
	}	
	override method terminar(){
		super()
		game.schedule(3000, { nivel3.iniciar()})
	}	
}
object pantalla2 {
	var property image = "nivel2.jpg"
	method iniciarpantalla() {
		game.addVisualIn(self, game.at(0,0))
		game.schedule(1000, { game.clear()
			nivel2.cargar()
		})	
>>>>>>> Stashed changes
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
