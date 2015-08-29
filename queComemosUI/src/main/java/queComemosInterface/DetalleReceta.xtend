package queComemosInterface

import dds.grupo9.queComemos.Estacion
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.RecetaSimple
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.aop.windows.TransactionalDialog

class DetalleReceta extends TransactionalDialog<Receta>{
	
	new(WindowOwner parent, Receta recetaModelo) {
		 super(parent, recetaModelo)
	}
	
	/*def static main ( String [] args ) {
		var recetaModelo = construirRecetaPrueba()
		new DetalleReceta(recetaModelo).startApplication()
	}
	
	def static construirRecetaPrueba() {
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
	}*/
	
	override createContents(Panel mainPanel) {
		this.title = "Detalle Receta"
		
		construirEncabezado(mainPanel)
		
      	super.createMainTemplate(mainPanel)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val secondaryPanel = new Panel(mainPanel)
		secondaryPanel.layout = new ColumnLayout(2) // Seteo nuevo panel en el cuerpo de la ventana con dos columnas
		contruirMitadIzquierda(secondaryPanel)
		construirMitadDerecha(secondaryPanel)
      	construirPie(mainPanel)
	}
	
	def construirPie(Panel mainPanel) {      	
      	/*Abajo*/
		new Label(mainPanel).text = "Proceso de preparación"
		      	new Label(mainPanel).bindValueToProperty("explicacion")
		      	//new Label(mainPanel).text = "EXPLICACION RECETA"
		      	val secondaryPanel4 = new Panel(mainPanel)
		      	secondaryPanel4.layout = new ColumnLayout(5)
		      	val subPanel1 = new Panel(secondaryPanel4)
		      	val subPanel2 = new Panel(secondaryPanel4)
		      	val subPanel3 = new Panel(secondaryPanel4)// SI FUNCIONARA EL ANCHO DEL BOTON ESTO SE PUEDE EVITAR
		      	new Button(subPanel3) => [
				caption = "Volver"
				onClick [ | 
					this.close()
				//this . modelObject . convertir 
				]
				//width = 60
				]
	}
	
	def construirMitadDerecha(Panel secondaryPanel) {
		/*Derecha*/
		val panelDerecho = new Panel(secondaryPanel)
		new Label(panelDerecho).text = "Temporada"
		new Label(panelDerecho).bindValueToProperty("temporadasCorrespondientes") //Deberia ser solo .head pero rompe
		new Label(panelDerecho).text = "TEMPORADA RECETA"
		
		     	new Label(panelDerecho).text = "Condimentos"
		     	new List(panelDerecho) => [
		           	bindItemsToProperty("condimentos")
		          	//bindValueToProperty("productoSeleccionado")
		            width = 200
		            height = 100
		      	]
		      	
		      	new Label(panelDerecho).text = "Condiciones preexistentes"
		      	new List(panelDerecho) => [
		           	bindItemsToProperty("condiciones")
		          	//bindValueToProperty("productoSeleccionado")
		            width = 200
		            height = 100
		      	]
	}
	
	def contruirMitadIzquierda(Panel secondaryPanel) {
		/*Izquierda*/
		val panelIzquierdo = new Panel(secondaryPanel)
		new Label(panelIzquierdo).text = "Dificultad"
		new Label(panelIzquierdo).bindValueToProperty("dificultad")
		//new Label(panelIzquierdo).text = "DIFICULTAD RECETA"
		
		new Label(panelIzquierdo).text = "Ingredientes"
		
		val table = new Table<Ingrediente>(panelIzquierdo, typeof(Ingrediente)) => [
			bindItemsToProperty("ingredientes")
			//bindValueToProperty("celularSeleccionado")
		]
		this.describeResultsGrid(table)
		
		val secondaryPanel3 = new Panel(panelIzquierdo)
		secondaryPanel3.layout = new ColumnLayout(2)
		val subPanelIzquierdo = new Panel(secondaryPanel3)
		val subPanelDerecho = new Panel(secondaryPanel3)
		var checkResumen = new CheckBox(subPanelIzquierdo)
		//checkResumen.bindEnabledToProperty("habilitaResumenCuenta")
		//checkResumen.bindValueToProperty("recetasFavoritas")
		new Label(subPanelDerecho).text = "Favorita"
	}
	
	def describeResultsGrid(Table<Ingrediente> table) {
		new Column<Ingrediente>(table) => [
		      	title = "Cantidad"
		     	fixedSize = 150
		      	bindContentsToProperty("cantidad")
		]
		
		new Column<Ingrediente>(table) => [
		      	title = "Ingrediente"
		     	fixedSize = 150
		      	bindContentsToProperty("nombre")
		]
	}
	
	def construirEncabezado(Panel mainPanel) {
		//new Label(mainPanel).text = "NOMBRE RECETA"
		new Label(mainPanel).bindValueToProperty("nombre")
		val secondaryPanel = new Panel(mainPanel)
		secondaryPanel.layout = new HorizontalLayout
		//new Label(secondaryPanel1).text = "CALORIAS RECETA "
		new Label(secondaryPanel).bindValueToProperty("calorias")
		new Label(secondaryPanel).text = "calorias "
		new Label(secondaryPanel).text = "Creado por: "
		//new Label(secondaryPanel1).text = "AUTOR RECETA "
		new Label(secondaryPanel).bindValueToProperty("dueño.nombre")
	}
	
}