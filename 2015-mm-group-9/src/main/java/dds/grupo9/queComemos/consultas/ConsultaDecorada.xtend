package dds.grupo9.queComemos.consultas

import java.util.Collection
import dds.grupo9.queComemos.Receta

interface ConsultaDecorada {
	
	def Collection<Receta> resultado()
	def Collection<Consulta> coleccionDeConsultas()	
	
	
}