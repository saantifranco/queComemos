package dds.grupo9.queComemos.manejoResultadosConsultas

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.ordenamientoResultados.CriterioDeOrdenamiento

class OrdenarPorCriterio implements Proceso {
	
	@Accessors CriterioDeOrdenamiento criterio
	
	override procesar(Collection<Receta> recetas){
		criterio.ordenar(recetas)
	}
	
	new(CriterioDeOrdenamiento criterio){
		this.criterio = criterio
	}
	
}