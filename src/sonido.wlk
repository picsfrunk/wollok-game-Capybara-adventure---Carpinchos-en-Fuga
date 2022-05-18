import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*

const musicaInicial = new Sound(file = "Simple Orange.mp3")
const musicaNivel1 = new Sound(file = "China.mp3")
const musicaNivel2 = new Sound(file = "Boat 14.mp3")
const musicaNivel3 = new Sound(file = "Crazy black light.mp3")
const sonidoGanar = new Sound(file = "China.mp3")
const sonidoPerder = new Sound(file = "China.mp3")

object musicConfig {
	var track = self.pista()
	method pista(){
		if (inicio & ! lvl) 
			return musicaInicial
		if (! inicio & lvl)
			if (nivel.nivel() == 1)
				return musicaNivel1
			if (nivel.nivel() == 2)
				return musicaNivel2
			if (nivel.nivel() == 2)
				return musicaNivel2
	}
	method musicaOnOff() {
		keyboard.m().onPressDo({ if (track.paused()) {
				track.resume()
			} else {
				track.pause()
			}
		})
	}
}