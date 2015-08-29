package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta
import java.util.Collection

interface Monitor {
	
	def void update(Persona persona, Collection<Receta> recetas)
	
}