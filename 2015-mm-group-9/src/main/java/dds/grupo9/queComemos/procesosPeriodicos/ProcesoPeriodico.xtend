package dds.grupo9.queComemos.procesosPeriodicos

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.consultas.Consulta

interface ProcesoPeriodico{
	
	
	def void ejecutar()
	
	def ProcesoPeriodico actualizar(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> recetas)
	
	def boolean cumpleCondicion(Persona persona, Collection<Receta> recetas)
	
	
}