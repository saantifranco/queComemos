package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Receta
import java.util.Collection
import dds.grupo9.queComemos.Persona
import org.eclipse.xtend.lib.annotations.Accessors

class VeganosQueConsultanRecetasDificiles implements Monitor {
	
	@Accessors int cantidadVeganos
	
	override void update(Persona persona, Collection<Receta> recetas){
		if(persona.esVegano()){
			var Iterable<Receta> recetasDificiles = newHashSet()
			recetasDificiles = recetas.filter[it.esDificil()]
			if(recetasDificiles.size > 0){
				cantidadVeganos++
			}
		}
	}
	
	def cantidadDeVeganosQueConsultaronRecetasDificiles(){
		cantidadVeganos
	}
	
	
}