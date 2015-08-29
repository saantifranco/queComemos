package dds.grupo9.queComemos.ordenamientoResultados

import java.util.Collection
import dds.grupo9.queComemos.Receta

interface CriterioDeOrdenamiento {
	
	def Collection<Receta> ordenar(Collection<Receta> recetas)
	
}