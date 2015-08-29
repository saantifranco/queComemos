package dds.grupo9.queComemos

import org.junit.Test
import static org.mockito.Mockito.*;
import dds.grupo9.queComemos.consultas.Consulta
import java.util.Collection
import dds.grupo9.queComemos.consultas.ConsultaPorDisgusto
import dds.grupo9.queComemos.consultas.ConsultaPorCaloriasMaximas
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.consultas.ConsultaPorIngredientesCaros
import dds.grupo9.queComemos.procesosPeriodicos.LoggerConsultas
import org.junit.Before
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.condicionPreexistente.Diabetico
import dds.grupo9.queComemos.manejoResultadosConsultas.Busqueda
import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import org.apache.log4j.Logger
import dds.grupo9.queComemos.procesosPeriodicos.Batch

class LoggerTestSuite {
	
	var RepoRecetasPropio repositorio;
	var Persona persona;
	var ConsultaPorCondicionesPreexistentes ccp;
	var ConsultaPorDisgusto cd;
	var ConsultaPorIngredientesCaros cic;
	var RecetaSimple receta1;
	var RecetaSimple receta2;
	var RecetaSimple receta3;
	var RecetaSimple receta4;
	var RecetaSimple receta5;
	var RecetaSimple receta6;
	var RecetaSimple receta7;
	var RecetaSimple receta8;
	var RecetaSimple receta9;
	var RecetaSimple receta10;
	var RecetaSimple receta11;
	var RecetaSimple receta12;
	var Batch batch = Batch.getInstance()
	
	@Before
	def void setup(){
		repositorio = new RepoRecetasPropio()
		persona = new Persona()
		persona.setRepoRecetas(repositorio)
		ccp = new ConsultaPorCondicionesPreexistentes()
		cd = new ConsultaPorDisgusto()
		cic = new ConsultaPorIngredientesCaros()
		
		receta1 = new RecetaSimple(persona)
		receta2 = new RecetaSimple(repositorio)
		receta3 = new RecetaSimple(persona)
		receta4 = new RecetaSimple(repositorio)
		receta5 = new RecetaSimple(repositorio)
		receta6 = new RecetaSimple(persona)
		receta7 = new RecetaSimple(repositorio)
		receta8 = new RecetaSimple(repositorio)
		receta9 = new RecetaSimple(persona)
		receta10 = new RecetaSimple(repositorio)
		receta11 = new RecetaSimple(repositorio)
		receta12 = new RecetaSimple(persona)
		
		receta1.agregarIngrediente(new Ingrediente("caldo"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente("sal"))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente("huevo"))
		receta3.calorias = 300
		receta4.agregarIngrediente(new Ingrediente())
		receta4.calorias = 500
		receta5.agregarIngrediente(new Ingrediente())
		receta5.calorias = 400
		receta6.agregarIngrediente(new Ingrediente())
		receta6.calorias = 700
		receta7.agregarIngrediente(new Ingrediente())
		receta7.calorias = 720
		receta8.agregarIngrediente(new Ingrediente())
		receta8.calorias = 740
		receta9.agregarIngrediente(new Ingrediente())
		receta9.calorias = 760
		receta10.agregarIngrediente(new Ingrediente())
		receta10.calorias = 800
		receta11.agregarIngrediente(new Ingrediente())
		receta11.calorias = 780
		receta12.agregarIngrediente(new Ingrediente())
		receta12.calorias = 770

		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		repositorio.agregarRecetaPublica(receta4)
		repositorio.agregarRecetaPublica(receta5)
		persona.agregarReceta(receta6)
		repositorio.agregarRecetaPublica(receta7)
		repositorio.agregarRecetaPublica(receta8)
		persona.agregarReceta(receta9)
		repositorio.agregarRecetaPublica(receta10)
		repositorio.agregarRecetaPublica(receta11)
		persona.agregarReceta(receta12)
	}
	
	@Test
	def unLoggerLoguea(){
		var LoggerConsultas logger = new LoggerConsultas();
		logger.logueoDePrueba();
	}
	
	@Test
	def unLoggerLogueaUnaConsultaConMasDeDiezRecetas(){
		var Logger loggerPosta = mock(Logger)
		var LoggerConsultas logger = new LoggerConsultas(loggerPosta)
		var Busqueda busqueda = new Busqueda()
		
		persona.agregarCondPreexistente(new Diabetico())
		ccp.decorado = cd;
		cd.decorado = cic;
		cic.decorado = persona;
		
		ccp.persona = persona;
		cd.persona = persona;
		cic.persona = persona;
		
		busqueda.fuenteDeDatos = ccp
		busqueda.persona = persona
		busqueda.agregarProcesoPeriodico(logger)
		persona.nombre = "Santiago";
		
		busqueda.resultadoSinProcesar()
		batch.ejecutarProcesosPeriodicos()		
		//logger.ejecutar
		
		verify(loggerPosta, times(1)).warn(any(Object))
	}
	
	@Test
	def unLoggerNoLogueaUnaConsultaConMenosDeDiezRecetas(){
		var LoggerConsultas logger = mock(LoggerConsultas)
		var Busqueda busqueda = new Busqueda()
		
		persona.agregarCondPreexistente(new Hipertenso())
		persona.agregarDisgusto("huevo");
		ccp.decorado = cd;
		cd.decorado = cic;
		cic.decorado = persona;
		
		ccp.persona = persona;
		cd.persona = persona;
		cic.persona = persona;
		
		busqueda.fuenteDeDatos = ccp
		busqueda.persona = persona
		busqueda.agregarProcesoPeriodico(logger)
		persona.nombre = "Santiago";
		
		busqueda.resultadoSinProcesar()
		
		batch.ejecutarProcesosPeriodicos()
		
		verify(logger,never()).logueoPendiente(any(Persona),anyCollectionOf(Consulta),anyCollectionOf(Receta))
	}
}