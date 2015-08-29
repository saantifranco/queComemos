package dds.grupo9.queComemos.procesosPeriodicos

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.EnviadorDeMail
import dds.grupo9.queComemos.consultas.Consulta

class EnviarMails implements ProcesoPeriodico {
	
	@Accessors Mail mail
	@Accessors EnviadorDeMail enviador
	
	override ejecutar(){
		enviador.enviar(mail)
	}
	
	override cumpleCondicion(Persona persona, Collection<Receta> recetas){
		persona.estaConfiguradaParaRecibirMails()
	}
	
	override actualizar(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> recetas) {
		var EnviarMails proceso = new EnviarMails()
		proceso.setMail(new Mail(filtrosAplicados, recetas.size))
		proceso.setEnviador(enviador)
		return proceso
	}
	
	def actualizarTest(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> recetas) {
		this.setMail(new Mail(filtrosAplicados, recetas.size))
	}
   	
}