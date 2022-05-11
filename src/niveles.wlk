import wollok.game.* 
import objects.*
import capybara.*
import enemies.* 

class Nivel {
	var property nivel = 1
	
	method image() = "nivel_" + self.nivel() + ".jpg"
	
	method validarPosition(position) {
		if (! position.x().between(0, game.width() -1)){
			self.error("Posicion fuera de ancho")
		}	
		
		if(! position.y().between(0, game.height() - 1)) {
			self.error("Posicion fuera de alto")
		}
	}
	
	method terminar() {
		game.schedule(3000, {game.stop()})
	}
	
	
}


object nivel1 inherits Nivel {
	
	
	method cargar() {
		
		game.addVisual(capybara)
		
	}
	
	
}

object nivel2 inherits Nivel{
	
	
}


object nivel3 inherits Nivel{
	
	
}

object validador {
	method validarPosition(position) {
		if (! position.x().between(0, game.width() -1)){
			self.error("Posicion fuera de ancho")
		}	
		
		if(! position.y().between(0, game.height() - 1)) {
			self.error("Posicion fuera de alto")
		}
	}
}
