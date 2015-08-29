package dds.grupo9.queComemos.consultas

import java.util.Collection
import dds.grupo9.queComemos.Receta

class ConsultaPorDisgusto extends Consulta{
	
	
	override filtrar(Collection <Receta> recetas){
		recetas.filter[persona.noContieneIngredientesQueLeDisgusten(it)]
	}
	
	override toString(){
		return "por disgutos";
	}
}