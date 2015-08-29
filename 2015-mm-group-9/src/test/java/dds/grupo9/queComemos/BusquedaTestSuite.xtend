package dds.grupo9.queComemos

import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.ordenamientoResultados.CriterioPorCalorias
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import org.junit.Test
import org.junit.Before
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.manejoResultadosConsultas.Busqueda
import dds.grupo9.queComemos.manejoResultadosConsultas.ObtenerLosDiezPrimeros
import dds.grupo9.queComemos.manejoResultadosConsultas.ConsiderarRecetasPares
import dds.grupo9.queComemos.manejoResultadosConsultas.OrdenarPorCriterio

class BusquedaTestSuite {
	
	var RepoRecetasPropio repositorio;
	var Persona persona;
	var ConsultaPorCondicionesPreexistentes filtro;
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
	
	@Before
	def void setup(){
		repositorio = new RepoRecetasPropio()
		persona = new Persona()
		persona.setRepoRecetas(repositorio)
		filtro = new ConsultaPorCondicionesPreexistentes()
		
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
		receta3.agregarIngrediente(new Ingrediente())
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
	def void unaPersonaPuedeObtenerLosDiezPrimerosResultadosDeUnaBusqueda(){
		
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val diezPrimeros = new ObtenerLosDiezPrimeros()
		busqueda.proceso = diezPrimeros
		persona.agregarCondPreexistente(new Hipertenso()) 
		
		filtro.persona = persona
		filtro.decorado = persona
		
		Assert.assertEquals(busqueda.resultado.size,10)
	}
	
	@Test
	
	def void unaPersonaPuedeObtenerSoloLas5RecetasParesDeUnaBusquedaQueDevuelve10Resultados(){
		
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val procesoPares = new ConsiderarRecetasPares()
		busqueda.proceso = procesoPares
		persona.agregarCondPreexistente(new Hipertenso()) 
		
		filtro.persona = persona
		filtro.decorado = persona

		Assert.assertEquals(busqueda.resultado.size,5)
	}
	
	@Test
	
	def void unaPersonaPuedeOrdenarLosResultadosDeUnaBusquedaSegunSusCalorias(){
		
		val criterioCal = new CriterioPorCalorias()
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val ordenar = new OrdenarPorCriterio(criterioCal)
		busqueda.proceso = ordenar
		persona.agregarCondPreexistente(new Hipertenso()) 
		
		filtro.persona = persona
		filtro.decorado = persona
		val recetasOrdenadas = #[receta3, receta5, receta4, receta6, receta7, receta8, receta9, receta12, receta11, receta10]

		Assert.assertEquals(busqueda.resultado, recetasOrdenadas)	
	}
	
}