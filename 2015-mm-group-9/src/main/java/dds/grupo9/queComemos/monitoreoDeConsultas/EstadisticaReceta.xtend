package dds.grupo9.queComemos.monitoreoDeConsultas

import org.eclipse.xtend.lib.annotations.Accessors

class EstadisticaReceta {
	
	@Accessors String nombre
	@Accessors int consultas
	
	new(String nom){
		this.nombre = nom
		consultas = 0		
	}
	
	def incrementarContador(){
		consultas+=1
	}
		
}