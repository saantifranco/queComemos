package dds.grupo9.queComemos.manejoResultadosConsultas

import java.util.Collection
import dds.grupo9.queComemos.Receta

class ConsiderarRecetasPares implements Proceso {
	
	override procesar(Collection<Receta> recetas){
		var recetasPares = newHashSet()
		var i = 0
		for(receta:recetas){
			if(i%2==0)
				recetasPares.add(receta)
			i++
		}
		recetasPares 
	}
	
}