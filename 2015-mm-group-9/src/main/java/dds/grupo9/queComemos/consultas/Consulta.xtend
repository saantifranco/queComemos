package dds.grupo9.queComemos.consultas

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta

abstract class Consulta implements ConsultaDecorada { 
	
	@Accessors Persona persona
	@Accessors ConsultaDecorada decorado
	
	def getPersona(){
		this.persona
	}
	
	override Collection<Receta> resultado() {
		var Collection<Receta> lista = newHashSet()
		lista.addAll(this.filtrar(decorado.resultado)) 
		persona.setUltimasRecetasConsultadas(lista)
		lista
	}
	
	override Collection<Consulta> coleccionDeConsultas(){
		var Collection<Consulta> consultas = newHashSet();
		consultas.add(this);
		consultas.addAll(decorado.coleccionDeConsultas());
		return consultas
	}
	
	def Iterable<Receta> filtrar(Collection<Receta> recetas) //Cada consulta filtrará con su lógica
}

