import wollok.game.* 
import objects.*
import enemies.*
import randomizer.*
import niveles.*

const pistaInicial = game.sound("Simple Orange.mp3")
const musicaNivel1 = game.sound("China.mp3")
const musicaNivel2 = game.sound("Boat 14.mp3")
const musicaNivel3 = game.sound("Crazy black light.mp3")
const sonidoGanar = game.sound("win.mp3")
const sonidoPerder = game.sound("lose.mp3")

object musicConfig {
	method musicaOnOff(pista) {
		keyboard.m().onPressDo({ if (pista.paused()) {
				pista.resume()
			} else {
				pista.pause()
			}
		})
	}
}