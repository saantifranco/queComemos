package dds.grupo9.queComemos.consultas

import java.util.Collection
import dds.grupo9.queComemos.Receta

class ConsultaPorCondicionesPreexistentes extends Consulta {
	
	
	override filtrar(Collection<Receta> recetas){
		recetas.filter[!persona.recetaNoRecomendada(it)]
	}
	
	override toString(){
		return "por condiciones preexistentes";
	}
	
}