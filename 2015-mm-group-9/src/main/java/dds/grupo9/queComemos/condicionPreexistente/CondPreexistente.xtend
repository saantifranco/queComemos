package dds.grupo9.queComemos.condicionPreexistente

import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona

interface CondPreexistente {
	 
	def boolean subsanaCondicion(Collection<String> gustos, String rutina, float peso) 
		
    def boolean recetaNoRecomendada(Receta receta)

	def boolean verificaDatosSegunCondicion(Persona persona) 
	
	def boolean esVeganismo()
}