package dds.grupo9.queComemos.modificacionRecetas

import dds.grupo9.queComemos.excepciones.NoLoTieneException
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Receta


class modEliminarIngredientes implements Modificacion {
	
	var Ingrediente ingrediente
	
	def setIngrediente(Ingrediente i){
		ingrediente = i	
	}
	
	override def ejecutar(Receta receta){
		if(receta.tieneIngrediente(ingrediente.nombre)){
			receta.eliminarIngredientesPorNombre(ingrediente.nombre)
		}
		else throw new NoLoTieneException("La receta no contiene ese ingrediente")
	}
}