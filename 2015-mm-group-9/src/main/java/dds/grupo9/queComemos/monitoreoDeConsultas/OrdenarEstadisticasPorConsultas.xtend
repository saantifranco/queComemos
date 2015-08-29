package dds.grupo9.queComemos.monitoreoDeConsultas

import java.util.Comparator

class OrdenarEstadisticasPorConsultas implements Comparator<EstadisticaReceta> {
	
	override def compare(EstadisticaReceta e1, EstadisticaReceta e2){
		return e2.consultas-e1.consultas
	}
	
}