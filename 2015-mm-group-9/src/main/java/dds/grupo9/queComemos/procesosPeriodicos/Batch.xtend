package dds.grupo9.queComemos.procesosPeriodicos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection

class Batch {
	
	@Accessors Collection<ProcesoPeriodico> procesosPeriodicos = newHashSet()	
	private static Batch instance = null;
   	
   	def public static Batch getInstance() {
      if(instance == null) {
         instance = new Batch();
      }
      return instance;
   	}
   	
   	def getProcesosPeriodicos(){
   		procesosPeriodicos
   	}
   	
   	def agregarProcesoPeriodico(ProcesoPeriodico procesoPer){
		procesosPeriodicos.add(procesoPer)
	}
	
	def ejecutarProcesosPeriodicos(){ 
		procesosPeriodicos.forEach[it.ejecutar()]
	}		
	
	/*def actualizarPendientes(Persona persona, Collection<Consulta> coleccionDeConsultas, Collection<Receta> resultado){
		creadoresProcesosPendientes.forEach[this.agregarProcesoPeriodico(it.actualizar(persona, coleccionDeConsultas, resultado))]
	}*/
	
}