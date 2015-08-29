package dds.grupo9.queComemos.consultas

import java.util.Collection
import dds.grupo9.queComemos.Receta

class ConsultaPorIngredientesCaros extends Consulta {
	
		
	override filtrar(Collection <Receta> recetas){
		recetas.filter[!it.tieneIngredientesCaros()]
	}
	
	override toString(){
		return "por ingredientes caros";
	}
	
}