package dds.grupo9.queComemos.repoRecetas

import queComemos.entrega3.dominio.Receta
import dds.grupo9.queComemos.RecetaSimple
import java.util.Collection
import dds.grupo9.queComemos.Ingrediente
import java.util.ArrayList
import java.util.List
import com.google.gson.reflect.TypeToken
import com.google.gson.Gson
import java.lang.reflect.Type
import org.eclipse.xtend.lib.annotations.Accessors
import queComemos.entrega3.repositorio.RepoRecetas

class RepoExternoAdapter {

	@Accessors RepoRecetas repositorioExterno

	new(){
		val repoExterno = new RepoRecetas
		this.repositorioExterno = repoExterno
	}

	def Collection<dds.grupo9.queComemos.Receta> adaptarJson(RepoRecetasExterno repoExterno) {
		var Collection <dds.grupo9.queComemos.Receta> recetasPropias = newHashSet()
		var List<Receta>recetasExternas = new ArrayList()
		var Type typeOfT = new TypeToken<Collection<Receta>>(){}.getType();
		var String resultadoJson
		
		resultadoJson = repositorioExterno.getRecetas(repoExterno.busquedaRecetas)
		recetasExternas = new Gson().fromJson(resultadoJson, typeOfT)
		recetasPropias.addAll(recetasExternas.map[this.adaptarReceta(repoExterno,it)])
		recetasPropias
	}

	def RecetaSimple adaptarReceta(RepoRecetasExterno repoExterno, Receta receta) {
		var RecetaSimple recetaAux = new RecetaSimple(repoExterno)
		recetaAux.nombre = receta.getNombre
		recetaAux.tiempoPreparacion = receta.getTiempoPreparacion
		recetaAux.calorias = receta.getTotalCalorias
		recetaAux.dificultad = receta.getDificultadReceta
		recetaAux.agregarTodosLosIngredientes(this.adaptarIngredientes(receta))
		recetaAux
	}
	
	def Collection <Ingrediente> adaptarIngredientes(Receta receta) {
		var Collection<Ingrediente> ingredientes = newHashSet()
		var List<String> ingredientesParaAdaptar = new ArrayList()
		ingredientesParaAdaptar = receta.getIngredientes
		for(ingredienteParaAdaptar : ingredientesParaAdaptar){
			ingredientes.add(new Ingrediente(ingredienteParaAdaptar))
			/*ingredientes.add(new Ingrediente(this.adaptarNombreIngrediente(ingredienteParaAdaptar)))*/
		}
		ingredientes
	}
	
	/*def Preferencia adaptarNombreIngrediente(String string) {
		Preferencia.valueOf(string.replaceAll(" ", "_").toUpperCase)
	}*/ // Ya no tiene sentido por el refactor dejamos de usar el enum Preferencia
	
	def recetasAdaptadas(RepoRecetasExterno repoExterno) {
		var Collection<dds.grupo9.queComemos.Receta> recetas = newHashSet()
		for(receta: repositorioExterno.filterRecetas(repoExterno.busquedaRecetas)){
			recetas.add(this.adaptarReceta(repoExterno, receta))
		}
		recetas
	}
	
}