package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import java.util.ArrayList

class RecetasMasConsultadasPorSexo extends RecetasMasConsultadas {
	
	var ArrayList<EstadisticaReceta> listaHombres = new ArrayList<EstadisticaReceta>()
	var ArrayList<EstadisticaReceta> listaMujeres = new ArrayList<EstadisticaReceta>()
	
	override void update(Persona persona, Collection<Receta> recetas){
		if(persona.sexo=="M"||persona.sexo=="m"){
			verificarExistencia(listaHombres,recetas)
			aumentarConsultasDeRecetas(listaHombres, recetas)
		} else if(persona.sexo=="F"||persona.sexo=="f"){
			verificarExistencia(listaMujeres,recetas)
			aumentarConsultasDeRecetas(listaMujeres, recetas)
		}	
	}
	
	def recetasMasConsultadasPorHombres(int cant){
		mostrarRecetasMasConsultadas(listaHombres, cant)
	}
	
	def recetasMasConsultadasPorMujeres(int cant){
		mostrarRecetasMasConsultadas(listaMujeres, cant)
	}	
}