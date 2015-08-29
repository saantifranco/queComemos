package dds.grupo9.queComemos.modificacionRecetas

import dds.grupo9.queComemos.Receta

interface Modificacion {
	
	def boolean ejecutar(Receta receta)	
}