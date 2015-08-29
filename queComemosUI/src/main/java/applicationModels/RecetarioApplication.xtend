package applicationModels

import org.uqbar.arena.Application
import queComemosInterface.LogueoWindow

class RecetarioApplication extends Application{
	static def void main(String[] args) {
		new RecetarioApplication().start()
	}
	
	override createMainWindow() {
		return new LogueoWindow(this)
	}
}