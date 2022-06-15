import wollok.game.*
object randomizer {
		
	method position() {
		return 	game.at( (1 .. game.width() - 2 ).anyOne(), game.height() - 2 ) 
	}
	method positionOnlyRight() {
		return game.at( ( 10 .. game.width() - 2 ).anyOne(), game.height() - 2 ) 
	} 
	method emptyPositionRight() {
		const position = self.positionOnlyRight()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPositionRight()
		}
	} 
	
	method positionOnlyLeft() {
		return game.at( ( 1 .. game.width() - 5 ).anyOne(), game.height() - 2 ) 
	} 
	
	method emptyPositionLeft() {
		const position = self.positionOnlyLeft()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPositionLeft()
		}
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