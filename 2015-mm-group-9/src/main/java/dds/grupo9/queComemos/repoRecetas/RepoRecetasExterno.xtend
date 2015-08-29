package dds.grupo9.queComemos.repoRecetas

import org.eclipse.xtend.lib.annotations.Accessors
import queComemos.entrega3.repositorio.BusquedaRecetas
import java.util.Collection
import dds.grupo9.queComemos.Receta

class RepoRecetasExterno implements dds.grupo9.queComemos.repoRecetas.RepoRecetas {
	
	@Accessors BusquedaRecetas busquedaRecetas
	@Accessors RepoExternoAdapter repoExternoAdapter
	
	new(){
		this.busquedaRecetas = new BusquedaRecetas()
		this. repoExternoAdapter = new RepoExternoAdapter()
	}
	
	override Collection<Receta> getRecetas() {
		var Collection<Receta> recetas = newHashSet()
		recetas.addAll(repoExternoAdapter.adaptarJson(this))
		recetas = recetas.sortBy[it.nombre]
	}
	
	def Collection<Receta> filterRecetas() {
		var Collection<Receta> recetas = newHashSet()
		recetas.addAll(repoExternoAdapter.recetasAdaptadas(this))
		recetas = recetas.sortBy[it.nombre]
	}

}