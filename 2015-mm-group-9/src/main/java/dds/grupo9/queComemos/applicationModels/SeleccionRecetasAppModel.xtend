package dds.grupo9.queComemos.applicationModels

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import dds.grupo9.queComemos.Receta
import java.util.Collection
import dds.grupo9.queComemos.monitoreoDeConsultas.EstadisticaReceta
import java.util.ArrayList

@Observable
@Accessors

class SeleccionRecetasAppModel {
	
	Persona persona = new Persona
	RecetasMasConsultadas monitorDeConsultas
	Receta recetaSeleccionada
 	String mensajeCorrespondiente = ""
 	Collection<Receta> seleccionDeRecetas = newHashSet()
 	
	
	new(Persona persona){
		this.persona = persona
		//this.seleccionarRecetasAdecuadas
	}
	
	def seleccionarRecetasAdecuadas(){
		if(persona.recetasFavoritas.length>0){
			seleccionDeRecetas.addAll(persona.recetasFavoritas)
			mensajeCorrespondiente = "Estas son tus recetas favoritas"
		}
	else{
			if(persona.ultimasRecetasConsultadas.length>0){
				seleccionDeRecetas.addAll(persona.ultimasRecetasConsultadas)
				mensajeCorrespondiente = "Estas fueron tus úĺtimas consultas"
			}
			else{
				seleccionDeRecetas.addAll(monitorDeConsultas.recetasMasConsultadas(persona.repoRecetas))
				mensajeCorrespondiente = "Estas son las recetas top del momento"
			}
		}
		
	}
}