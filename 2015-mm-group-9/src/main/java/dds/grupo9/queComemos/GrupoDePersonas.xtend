package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection

class GrupoDePersonas {
	
	@Accessors String nombre
	var Collection <String> gustos = newHashSet()
	var Collection <Persona> integrantes = newHashSet()
	var Collection <Receta> recetasEnComun = newHashSet()
	
	new(String nombreGrupo){
		nombre=nombreGrupo
		
	}
	
	def getGustos(){
		this.gustos
	}
	
	def getIntegrantes(){
		this.integrantes
	}
	
	def getRecetas(){
		this.recetasEnComun
	}
	
	def int cantidadDeRecetas(){
		recetasEnComun.size
		
	}
	
	
	def agregarPreferencia(String preferencia){
		gustos.add(preferencia)
	}
	
	def agregarAGrupo(Persona persona){
		integrantes.add(persona)
		persona.agregarGrupo(this)
	}
	
	def incluyeA(Persona persona) {
		integrantes.exists[i|i==persona]
	}
	
	def leGusta(String preferencia) {
		gustos.contains(preferencia)
	}
	
	def laRecetaEsApropiadaParaTodos(Receta receta) {
		integrantes.forall[!it.recetaNoRecomendada(receta)]
	}
	
	def listarRecetasDeGrupo(){
		integrantes.forEach[i|i.agregarSusRecetas(recetasEnComun)]
		return recetasEnComun
	}
	
		
	def contieneAlgunIngredienteQuePrefiereElGrupo(Receta unaReceta){
		gustos.exists[unaReceta.tieneIngrediente(it)] 
	}
}