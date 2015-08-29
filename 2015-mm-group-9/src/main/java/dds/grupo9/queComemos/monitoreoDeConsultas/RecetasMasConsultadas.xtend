package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import java.util.ArrayList
import java.util.Collections
import dds.grupo9.queComemos.repoRecetas.RepoRecetas

class RecetasMasConsultadas implements Monitor {
	
	var ArrayList<EstadisticaReceta> listaEstadisticas = new ArrayList<EstadisticaReceta>()
	
	
	override void update(Persona persona, Collection<Receta> recetas){
		verificarExistencia(listaEstadisticas, recetas)
		aumentarConsultasDeRecetas(listaEstadisticas, recetas)	
	}
	
	def verificarExistencia(ArrayList<EstadisticaReceta> lista, Collection<Receta> recetas){
		for (receta:recetas){
			if (!(lista.exists[e | e.nombre == receta.nombre])){
				val recetaNueva = new EstadisticaReceta(receta.nombre)
				lista.add(recetaNueva)
			} 
		}
	}
	
	def aumentarConsultasDeRecetas(ArrayList<EstadisticaReceta> lista, Collection<Receta> recetas){
		for(receta:recetas){
			lista.filter[e | e.nombre == receta.nombre].forEach[e | e.incrementarContador]
		}
	}
	
	def recetasMasConsultadas(int cant){
		mostrarRecetasMasConsultadas(listaEstadisticas, cant)
	}
	
	def mostrarRecetasMasConsultadas(ArrayList<EstadisticaReceta> lista, int cant){
		var Collection<String> recetasConsultadas = newHashSet() 
		Collections.sort(lista, new OrdenarEstadisticasPorConsultas())
		recetasConsultadas.addAll(lista.map[it.nombre].take(cant))
		return recetasConsultadas
	}
	
	def  Collection<Receta> recetasMasConsultadas(RepoRecetas repositorio) {
		var Collection<Receta> recetas = newHashSet()
		var ArrayList<String> listaNombresRecetasConsultadas = new ArrayList()
		listaNombresRecetasConsultadas.addAll(listaEstadisticas.map[it.nombre])
		recetas.addAll(repositorio.getRecetas)
		for(r:recetas){
			if(!listaNombresRecetasConsultadas.contains(r.nombre)) recetas.remove(r)
		}
		recetas
	}
	
	/*override void update(Persona persona, Collection<Receta> recetas){
		recetas.forEach[receta| 
			if(!recetasConsultadas.exists[r|r.nombre == receta.nombre]){	
				recetasConsultadas.add(receta)
				receta.aumentarCantidadDeVecesConsultada()
			}
			else recetasConsultadas.forEach[r| if(r.nombre == receta.nombre) r.aumentarCantidadDeVecesConsultada()]
		]
	}*/
}