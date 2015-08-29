package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.consultas.Consulta
import java.util.Collection

class Mail {
	
	var String filtrosAplicados = ""
	@Accessors int cantResultados
	@Accessors String destino = "administrador@gmail.com"
	
	new(){
		
	}
	
	new (Collection<Consulta> filtrosAplicados, int cantResultados){
   		this.setFiltrosAplicados(filtrosAplicados)
   		this.setCantResultados(cantResultados)
   	}
   	
	def setFiltrosAplicados(Collection<Consulta> consultas) {
		for(consulta:consultas){
			if(consulta == consultas.head)
			{
				filtrosAplicados = consulta.toString();
			}
			else
			{
				filtrosAplicados = filtrosAplicados + ", " + consulta.toString();	
			}
		}
		filtrosAplicados = filtrosAplicados + ".";
	}
	
	def setFiltrosAplicadosManualmente(String filtros){
		filtrosAplicados = filtros
	}
	
	def getFiltrosAplicados(){
		filtrosAplicados
	}
	
}