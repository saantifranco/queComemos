package dds.grupo9.queComemos.ordenamientoResultados

import java.util.Collection
import dds.grupo9.queComemos.Receta

class CriterioPorCalorias implements CriterioDeOrdenamiento {
	
	new(){
		
	}
	override ordenar(Collection<Receta> recetas){
		recetas.sortBy(r|r.calorias)
	}
	
}