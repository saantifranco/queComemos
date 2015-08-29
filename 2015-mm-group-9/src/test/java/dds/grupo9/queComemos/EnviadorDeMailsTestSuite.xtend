package dds.grupo9.queComemos

import static org.mockito.Mockito.*;
import org.junit.Test
import dds.grupo9.queComemos.procesosPeriodicos.EnviarMails
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.repoRecetas.RepoRecetasExterno
import org.junit.Before
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.manejoResultadosConsultas.Busqueda
import org.junit.Assert
import dds.grupo9.queComemos.consultas.ConsultaPorIngredientesCaros
import dds.grupo9.queComemos.procesosPeriodicos.Batch

class EnviadorDeMailsTestSuite {
	
	var RepoRecetasPropio repositorio;
	var RepoRecetasExterno repoExterno;
	var Persona persona;
	var ConsultaPorCondicionesPreexistentes filtro;
	var ConsultaPorIngredientesCaros filtro2;
	var RecetaSimple receta1;
	var RecetaSimple receta2;
	var RecetaSimple receta3;
	var RecetaSimple receta4;
	var Batch batch = Batch.getInstance();
	
	@Before
	def void setup(){
		repositorio = new RepoRecetasPropio()
		repoExterno = new RepoRecetasExterno()
		persona = new Persona()
		persona.setRepoRecetas(repositorio)
		filtro = new ConsultaPorCondicionesPreexistentes()
		filtro2 = new ConsultaPorIngredientesCaros()
		persona.setRepoRecetas(repositorio)
		persona.peso = 120f
		persona.altura = 1.7f
		persona.agregarCondPreexistente(new Hipertenso())
		
		receta1 = new RecetaSimple(persona)
		receta2 = new RecetaSimple(repositorio)
		receta3 = new RecetaSimple(persona)
		receta4 = new RecetaSimple(persona)
		
		receta1.agregarIngrediente(new Ingrediente("sal"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente("pescado"))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente("lomo"))
		receta3.calorias = 300
		receta4.agregarIngrediente(new Ingrediente("huevo"))
		receta4.calorias = 300

		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		persona.agregarReceta(receta4)
	}
	
	@Test
	def unEnviadorDeMailsEnviaMailAUnaPersonaVigilada() {
		var enviadorDeMails = mock(EnviadorDeMail)
		var enviarMails = new EnviarMails()
		var busqueda = new Busqueda()
		busqueda.batch = batch
		
		busqueda.fuenteDeDatos = filtro2
		busqueda.persona = persona	
		filtro.decorado = persona
		filtro.persona = persona
		filtro2.persona = persona
		filtro2.decorado = filtro

		persona.configurarParaRecibirMail()				
		enviarMails.enviador = enviadorDeMails
		
		busqueda.agregarProcesoPeriodico(enviarMails)
		busqueda.resultadoSinProcesar()
		
		batch.ejecutarProcesosPeriodicos()
		
		Assert.assertEquals(1, batch.procesosPeriodicos.size)
		verify(enviadorDeMails,times(1)).enviar(any(Mail))
	}
	
	@Test
	def unEnviadorDeMailsNoEnviaMailAUnaPersonaQueNoEstaVigilada() {
		var enviadorDeMails = mock(EnviadorDeMail)
		var enviarMails = new EnviarMails()
		var busqueda = new Busqueda()
		busqueda.batch = batch
		
		busqueda.fuenteDeDatos = filtro2
		busqueda.persona = persona	
		filtro.decorado = persona
		filtro.persona = persona
		filtro2.persona = persona
		filtro2.decorado = filtro
				
		enviarMails.enviador = enviadorDeMails
		busqueda.agregarProcesoPeriodico(enviarMails)
		
		busqueda.resultadoSinProcesar
		
		batch.ejecutarProcesosPeriodicos()
		
		Assert.assertEquals(0, batch.procesosPeriodicos.size)
		verify(enviadorDeMails, never()).enviar(any(Mail))
	}
	
	@Test
	def unMailContieneLosFiltrosAplicadosYLaCantidadDeResultadosObtenidosEnLaConsultaYElMailDeLaPersona() {
		var enviarMails = new EnviarMails()
		var busqueda = new Busqueda()
		var mail = new Mail()
		busqueda.batch = batch
		
		busqueda.fuenteDeDatos = filtro2
		busqueda.persona = persona	
		filtro.decorado = persona
		filtro.persona = persona
		filtro2.persona = persona
		filtro2.decorado = filtro
		
		mail.setFiltrosAplicadosManualmente("por ingredientes caros, por condiciones preexistentes.")
		mail.cantResultados = 2
		
		persona.configurarParaRecibirMail()
		busqueda.agregarProcesoPeriodico(enviarMails)
		
		enviarMails.actualizarTest(persona, busqueda.fuenteDeDatos.coleccionDeConsultas, busqueda.fuenteDeDatos.resultado)
		
		Assert.assertEquals(mail.destino, enviarMails.mail.destino)
		Assert.assertEquals(mail.cantResultados, enviarMails.mail.cantResultados)
		Assert.assertEquals(mail.filtrosAplicados, enviarMails.mail.filtrosAplicados)
		
//El problema está en que el proceso que contiene el mail del cual se quiere conocer la información no es el enviarMails de este test
//sino que es un nuevo proceso que está en el batch, y no se cómo sacar la información de ese proceso
	}
}