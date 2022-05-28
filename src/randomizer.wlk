import wollok.game.*
object randomizer {
		
	method position() {
		return 	game.at( 
					(1 .. game.width() - 2 ).anyOne(), game.height() - 2 ) 
	}
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	} 
	
}