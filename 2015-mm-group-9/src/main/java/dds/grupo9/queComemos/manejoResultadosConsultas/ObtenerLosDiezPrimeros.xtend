package dds.grupo9.queComemos.manejoResultadosConsultas

import java.util.Collection
import dds.grupo9.queComemos.Receta

class ObtenerLosDiezPrimeros implements Proceso {
	
	override procesar(Collection<Receta> recetas){
		var Collection<Receta> lista = newHashSet()
		lista.addAll(recetas.take(10))
		lista
	}
	
}