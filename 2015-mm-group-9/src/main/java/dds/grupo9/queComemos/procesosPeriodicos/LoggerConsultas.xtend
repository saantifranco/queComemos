package dds.grupo9.queComemos.procesosPeriodicos

import org.apache.log4j.Logger

import org.apache.log4j.Logger
import org.apache.log4j.PropertyConfigurator
import org.apache.log4j.FileAppender
import org.apache.log4j.ConsoleAppender
import org.apache.log4j.PatternLayout
import java.io.OutputStreamWriter
import java.util.Collection
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.consultas.Consulta
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.consultas.ConsultaDecorada
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

class LoggerConsultas implements ProcesoPeriodico{

	private static Logger log;
	@Accessors String logPendiente
	
	new(){
		log = Logger.getLogger(LoggerConsultas.getClass())
	}
	
	new(Logger logExterno)
	{
		//solo para tests
		log = logExterno
	}
	
	def public void logueoDePrueba() {
		/*var ConsoleAppender ca = new ConsoleAppender();
		ca.setWriter(new OutputStreamWriter(System.out));
		ca.setLayout(new PatternLayout("%-5p [%t]: %m%n"));
		log.addAppender(ca);*/
		
		//BasicConfigurator.configure()
		//log.addAppender(new FileAppender)
		
 		PropertyConfigurator.configure(this.getClass().getResource("log4j.properties"))
 		log.trace("Este es un mensaje de Trace")
 		log.info("Este es un mensaje de Info")
  		log.warn("Este es un mensaje de Warning")
  		log.error("Este es un mensaje de Error")
  		log.fatal("Este es un mensaje de Fatal")
	}
	
	def public void logueoPendiente(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> resultados){
			PropertyConfigurator.configure(this.getClass().getResource("log4j.propiedadesLogueoConsulta"))
			var String filtrosAplicadosString = "";
			for(consulta:filtrosAplicados){
				if(consulta == filtrosAplicados.head)
				{
					filtrosAplicadosString = consulta.toString();
				}
				else
				{
					filtrosAplicadosString = filtrosAplicadosString + ", " + consulta.toString();	
				}
			}
			filtrosAplicadosString = filtrosAplicadosString + ".";
			this.setLogPendiente("Consulta realizada por " + persona.nombre + ". Arrojó " + resultados.size() + " resultados. Filtros aplicados: " + filtrosAplicadosString)
	}
	
	override ejecutar() {
		log.warn(logPendiente)
	}
	
	override cumpleCondicion(Persona persona, Collection<Receta> recetas){
		recetas.size()>10
	}
	
	override actualizar(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> recetas) {
		this.logueoPendiente(persona, filtrosAplicados, recetas)
		return this
//		Está hecho así porque si se hace como está comentado abajo no hay forma de testearlo ya que habría un nuevo logger guardado en el batch y no el que se busca testear 
		/*var LoggerConsultas logueo = new LoggerConsultas()
		logueo.logueoPendiente(persona, filtrosAplicados, recetas)
		return logueo*/
	}
	
}