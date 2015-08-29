package queComemosInterface

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import dds.grupo9.queComemos.applicationModels.LogueoAppModel

class LogueoWindow extends SimpleWindow<LogueoAppModel> {
	
	new(WindowOwner parent) {
     	super(parent, new LogueoAppModel)
    }
	
 	override createContents(Panel mainPanel) {
		title = "Login"
		taskDescription = "Ingrese su usuario y contraseña"
		super.createMainTemplate(mainPanel)

	}
 	
	override def createFormPanel(Panel mainPanel) {
		crearPanelTop(mainPanel)
		crearPanelMid(mainPanel)
	}
	
	override addActions(Panel actionsPanel) {	
  		new Button(actionsPanel) => [
			caption = "Log In"
			onClick [
				var personaBuscada = this.modelObject.personaBuscada()
				val seleccionRecetas = new SeleccionRecetas(this, personaBuscada)
				this.close
				seleccionRecetas.open()
			]
		]

	}

	def crearPanelTop(Panel panel) {
		var Panel nombrePanel = new Panel(panel)
		this.title = "Log In"
		new Label(nombrePanel).text = "Ingrese nombre de usuario: "
		new TextBox(nombrePanel).bindValueToProperty("persona.nombre")
		nombrePanel.width = 100
	}

	def crearPanelMid(Panel panel) {
		var Panel contraseñaUsuarioPanel = new Panel(panel)
		new Label(contraseñaUsuarioPanel).text = "Ingrese contraseña: "
		new TextBox(contraseñaUsuarioPanel).bindValueToProperty("contrasegna")
		
	}
}