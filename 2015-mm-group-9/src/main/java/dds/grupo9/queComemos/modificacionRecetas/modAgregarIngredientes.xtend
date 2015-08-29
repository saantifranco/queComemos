package dds.grupo9.queComemos.modificacionRecetas


import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Receta

class modAgregarIngredientes implements Modificacion {
	
	var Ingrediente ingrediente

	def setIngrediente(Ingrediente i){
		ingrediente = i	
	}	
	
	override def ejecutar(Receta receta){
		receta.agregarIngrediente(ingrediente)
	}
	
}