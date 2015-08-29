package dds.grupo9.queComemos.repoRecetas

import java.util.Collection
import dds.grupo9.queComemos.excepciones.NoLoTieneException
import dds.grupo9.queComemos.Receta

class RepoRecetasPropio implements dds.grupo9.queComemos.repoRecetas.RepoRecetas {
	
	var Collection <Receta> recetasPublicas = newHashSet()
	def tieneRecetaPublica(String nombreReceta){
		recetasPublicas.exists[it.nombre==nombreReceta]
		
	}
	
	def void agregarRecetaPublica(Receta receta){
		recetasPublicas.add(receta)
	}
	
		
	def quitarRecetaPublica(Receta receta){
		if(tieneRecetaPublica(receta.nombre))
		recetasPublicas.remove(receta)
		else throw new NoLoTieneException ("No existe esta receta publica")
		
	}
	
	override Collection<Receta> getRecetas(){
		
		this.recetasPublicas
	}
	
}