package dds.grupo9.queComemos

import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import dds.grupo9.queComemos.excepciones.NoLoTieneException

class RecetaPublica implements PrivacidadReceta {
	
	
	
	
	override puedeVermeOModificarme(Persona persona){
		
		true
	}
	
	override cambiosDeReceta (Persona persona, Modificacion modificacion,Receta receta ){
	
	    var recetaCopia = receta.copiaReceta(persona)
	    persona.agregarReceta(recetaCopia)
	    modificacion.ejecutar(recetaCopia)
	}
	
	override getDueño() {
		throw new NoLoTieneException("Una receta pública no tiene dueño")
	}
	
}