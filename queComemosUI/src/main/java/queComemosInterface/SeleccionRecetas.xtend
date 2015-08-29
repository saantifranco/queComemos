package queComemosInterface

import dds.grupo9.queComemos.Receta
import org.uqbar.arena.widgets.Panel
import dds.grupo9.queComemos.Persona
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.windows.Dialog
import dds.grupo9.queComemos.applicationModels.SeleccionRecetasAppModel
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.RecetaSimple
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.Estacion

class SeleccionRecetas extends SimpleWindow <SeleccionRecetasAppModel> {
	
	new(WindowOwner owner, Persona persona) {
     	super(owner, new SeleccionRecetasAppModel(persona))
 	}
 
 	/*def static main ( String [] args ) {
  		var Collection<Receta> seleccionDeRecetas = newHashSet()
  		var Persona persona = new Persona()
  		new SeleccionRecetas(persona).startApplication
 	}*/
 	
 	override def createMainTemplate(Panel mainPanel) {
		title = "Recetas"
		taskDescription = "Elija la receta que desea ver en detalle"
		
		super.createMainTemplate(mainPanel)

		this.createGridActions(mainPanel)
	}
 
 	override createFormPanel(Panel mainPanel) {
	  	this.title = "Bienvenido a ¿Qué comemos?"
	  	new Label(mainPanel).setText = "mensajeCorrespondiente"
  		//new Label(mainPanel).bindValueToProperty("mensajeCorrespondiente") ASI DEBERIA SER
  		val table = new Table<Receta>(mainPanel, typeof(Receta)) => [
  			bindItemsToProperty("persona.recetasFavoritas")
	   		//bindItemsToProperty("seleccionDeRecetas") ASI DEBERIA SER
   			bindValueToProperty("recetaSeleccionada")
  		]
  		this.describeResultsGrid(table)
  	}
  	
  	override addActions(Panel actionsPanel) {	
  		/*new Button(actionsPanel) => [
	    	caption = "Ver"
    		//onClick [ | this . modelObject . convertir ]
    		height = 40
    		width = 5
  		]*/
	}
 
	def describeResultsGrid(Table <Receta> table) {
  		new Column<Receta>(table) => [
	        title = "Nombre"
    		fixedSize = 150
        	bindContentsToProperty("nombre")
  		]
  
  		new Column<Receta>(table) => [
    		title = "Calorías"
        	fixedSize = 150
        	bindContentsToProperty("calorias")
  		]
  
  		new Column<Receta>(table) => [
	        title = "Dificultad"
    	    fixedSize = 150
        	bindContentsToProperty("dificultad")
  		]
  
  		new Column<Receta>(table) => [
        	title = "Temporada"
	        fixedSize = 150
    	    bindContentsToProperty("temporadasCorrespondientes")
  		]
	}
	
	def void createGridActions(Panel mainPanel) {
		//val elementSelected = new NotNullObservable("recetaSeleccionada") NO SE QUE ES ESTO
		
		val actionsPanel = new Panel(mainPanel).layout = new HorizontalLayout
		
		new Button(actionsPanel) => [
			caption = "Ver"
			onClick [ |
				this.verReceta	
			]
			//bindEnabled(elementSelected) NO SE QUE ES, ESTA ASOCIADO A LO DE ARRIBA CREO
		]
	}
	
	def void verReceta() {
		//this.openDialog(new DetalleReceta(this, modelObject.recetaSeleccionada)) ASI DEBERIA FUNCIONAR PERO NO ANDDA
		this.openDialog(new DetalleReceta(this, this.construirRecetaPrueba))
	}
	
	def openDialog(Dialog<?> dialog) {
		//dialog.onAccept[|modelObject.getReceta]
		dialog.open
	}
	
	def construirRecetaPrueba() {
		var p = new Persona
		p.nombre = "Santiago"
		var r = new RecetaSimple(p)
		r.nombre = "Ravioles con crema"
		r.calorias = 550
		r.dificultad = Dificultad.FACIL
		r.agregarIngrediente(new Ingrediente("Harina", 500))
		r.agregarIngrediente(new Ingrediente("Huevos", 3))
		r.agregarIngrediente(new Ingrediente("Aceite", 3))
		r.agregarIngrediente(new Ingrediente("Agua", 200))
		r.agregarIngrediente(new Ingrediente("Queso azul", 200))
		r.agregarIngrediente(new Ingrediente("Espinaca", 1))
		r.agregarIngrediente(new Ingrediente("Jamon", 100))
		r.agregarCondimento("Sal")
		r.agregarCondimento("Salsa de soja")
		r.agregarCondimento("Nueces")
		r.agregarCondicion(new Vegano)
		r.agregarCondicion(new Celiaco)
		r.agregarCondicion(new Hipertenso)
		r.agregarTemporada(Estacion.VERANO)
		r.agregarTemporada(Estacion.OTOGNO)
		r.explicacion = "Preparar la masa mezclando el harina, los huevos, el agua y el aceite. 
		Dejar reposar. Cortar en forma de tapas circulares. Preparar relleno. 
		Armar los ravioes. Hervir, colar y servir. Poner crema, nueces y salsa de soja a gusto!!"
		return r
	}
}