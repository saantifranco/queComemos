package dds.grupo9.queComemos.monitoreoDeConsultas

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import java.util.Calendar
import java.util.Hashtable
import dds.grupo9.queComemos.Receta
import java.util.Collection

class MonitorSinObservers {
	
	@Accessors int hour
	@Accessors int x
	@Accessors int cantidadDeVeganos
	@Accessors int valor
	var consultasPorHora = newIntArrayOfSize(24)
	var Calendar calendario = Calendar.getInstance()
	var Hashtable<String, Integer> resultados = new Hashtable<String, Integer>()
	var Hashtable<String, Integer> resultadosHombres = new Hashtable<String, Integer>()
	var Hashtable<String, Integer> resultadosMujeres = new Hashtable<String, Integer>()
	
	def void procesarRecetasMasConsultadas(Collection<Receta> recetas){
		recetas.forEach[ordenarTabla(resultados, it)]
	}
	
	def ordenarTabla(Hashtable<String,Integer> hashtable, Receta receta){
		if(hashtable.containsKey(receta.nombre)){
			hashtable.getOrDefault(receta.nombre, valor)
			hashtable.replace(receta.nombre, valor+1)
		} else {
			hashtable.put(receta.nombre, 1)
		}
	}
	
	def recetasMasConsultadas(int cant){
		mostrarRecetasMasConsultadas(resultados, cant)
	}
	
	def mostrarRecetasMasConsultadas(Hashtable<String,Integer> hashtable, int cant){
		hashtable.values.sort.reverse.take(cant)
		return hashtable.keys
	}
		
	def void procesarConsultaPorSexo(Collection<Receta> recetas, Persona persona){
		recetas.forEach[
			if(persona.sexo == "M" || persona.sexo == "m"){
				ordenarTabla(resultadosHombres, it)
			} else if(persona.sexo=="F" || persona.sexo=="f"){
				ordenarTabla(resultadosMujeres, it)
			}
		]
	}
	
	def recetasMasConsultadasPorHombres(int cantidad){
		mostrarRecetasMasConsultadas(resultadosHombres, cantidad)
	}
	
	def recetasMasConsultadasPorMujeres(int cantidad){
		mostrarRecetasMasConsultadas(resultadosMujeres, cantidad)
	}
	
	def void procesarConsultaVeganosRecetasDificiles(Collection<Receta> recetas, Persona persona){
		if(persona.esVegano()){
			var Iterable<Receta> recetasDificiles = newHashSet()
			recetasDificiles = recetas.filter[it.esDificil()]
			if(recetasDificiles.size > 0){
				cantidadDeVeganos++
			}
		}
	}
	
	def cantidadDeVeganosQueConsultaronRecetasDificiles(){
		cantidadDeVeganos
	}
	
	
	def void procesarConsultaPorHora(){
		hour = calendario.get(Calendar.HOUR_OF_DAY)
		x = consultasPorHora.get(hour)
		consultasPorHora.set(hour, x++)
	}
	
	def consultasPorHora(int hora){
		if(hora>23 || hora<0){
			throw new RuntimeException("no es una hora válida")
		} else {
			consultasPorHora.get(hora)
		}
	}
	
}