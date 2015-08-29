package dds.grupo9.queComemos.condicionPreexistente

import java.util.Collection
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona

class Hipertenso implements CondPreexistente {
	var Collection<Ingrediente> prescripcionesMedicas = newHashSet()
	
	new(){
    	prescripcionesMedicas.add(new Ingrediente("sal",0))
    	prescripcionesMedicas.add(new Ingrediente("caldo",0))
	}
	
	override toString()
	{
		"Hipertenso"
	}
	
	def getPrescripcionesMedicas(){
		this.prescripcionesMedicas
	}
	
	override boolean subsanaCondicion(Collection<String> gustos, String rutina, float peso){
		rutina == "INTENSIVO"
	} /*Verifica si logra subsanar su condición, para los hipertensos esto se logra si tiene una rutina activa intensiva con ejercicio adicional */

    override boolean recetaNoRecomendada(Receta receta){
    	prescripcionesMedicas.exists[ing | receta.tieneIngrediente(ing.nombre)]
    }
       
    override boolean verificaDatosSegunCondicion(Persona persona){/* Verifica que usuarios hipertensos indiquen al menos una preferencia */
    	persona.tienePreferencias
    }
    
    override boolean esVeganismo(){false}   
}