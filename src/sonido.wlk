import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*

const pistaInicial = game.sound("Simple Orange.mp3")
const musicaNivel1 = game.sound("China.mp3")
const musicaNivel2 = game.sound("Boat 14.mp3")
const musicaNivel3 = game.sound("Crazy black light.mp3")
const sonidoGanar = game.sound("China.mp3")
const sonidoPerder = game.sound("China.mp3")

object musicConfig {
//	var track = self.pista()
//	method pista(){
//		if (pantallaInicio & ! lvl) 
//			return musicaInicial
//		if (! inicio & lvl)
//			if (nivel1.enCurso() == true)
//				return musicaNivel1
//			if (nivel2.enCurso() == true)
//				return musicaNivel2
//			if (nivel3.enCurso() == true)
//				return musicaNivel2
//		else{
//			return 0
//		}
//	}
	method musicaOnOff(pista) {
		keyboard.m().onPressDo({ if (pista.paused()) {
				pista.resume()
			} else {
				pista.pause()
			}
		})
	}
}