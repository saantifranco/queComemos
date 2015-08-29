package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.ordenamientoResultados.CriterioPorCalorias
import java.util.Collection
import queComemos.entrega3.repositorio.BusquedaRecetas
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.repoRecetas.RepoRecetasExterno
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import org.junit.Before
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.consultas.ConsultaPorCaloriasMaximas
import dds.grupo9.queComemos.consultas.ConsultaPorDisgusto
import dds.grupo9.queComemos.consultas.ConsultaPorIngredientesCaros
import dds.grupo9.queComemos.manejoResultadosConsultas.Busqueda
import dds.grupo9.queComemos.manejoResultadosConsultas.ObtenerLosDiezPrimeros
import dds.grupo9.queComemos.manejoResultadosConsultas.ConsiderarRecetasPares
import dds.grupo9.queComemos.manejoResultadosConsultas.OrdenarPorCriterio

class RepoRecetasExternoTestSuit {
	
	var RepoRecetasExterno repoExterno;
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
		repoExterno = new RepoRecetasExterno()
		persona = new Persona()
		persona.setRepoRecetas(repoExterno)
		filtro = new ConsultaPorCondicionesPreexistentes()
		
		receta1 = new RecetaSimple(persona)
		receta2 = new RecetaSimple(persona)
		receta3 = new RecetaSimple(persona)
		receta4 = new RecetaSimple(persona)
		receta5 = new RecetaSimple(persona)
		receta6 = new RecetaSimple(persona)
		receta7 = new RecetaSimple(persona)
		receta8 = new RecetaSimple(persona)
		receta9 = new RecetaSimple(persona)
		receta10 = new RecetaSimple(persona)
		receta11 = new RecetaSimple(persona)
		receta12 = new RecetaSimple(persona)
		
		receta1.agregarIngrediente(new Ingrediente("caldo"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente("sal"))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente("carne"))
		receta3.calorias = 300
		receta4.agregarIngrediente(new Ingrediente("pescado"))
		receta4.calorias = 500
		receta5.agregarIngrediente(new Ingrediente("lomo"))
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
		persona.agregarReceta(receta2)
		persona.agregarReceta(receta3)
		persona.agregarReceta(receta4)
		persona.agregarReceta(receta5)
		persona.agregarReceta(receta6)
		persona.agregarReceta(receta7)
		persona.agregarReceta(receta8)
		persona.agregarReceta(receta9)
		persona.agregarReceta(receta10)
		persona.agregarReceta(receta11)
		persona.agregarReceta(receta12)
	}
	
//ENTREGA 3 TEST
	
	@Test
	def unGetterTraeTodasLasRecetasDelRepositorioExternoEnJsonYElAdapterLaConvierteCorrectamente(){
		var Collection<dds.grupo9.queComemos.Receta> recetas = newHashSet()
		recetas = repoExterno.getRecetas()
		Assert.assertEquals(12, recetas.size)
		Assert.assertEquals("canelones de ricota y verdura", recetas.head.nombre) // NOTA: mi adaptar ordena por nombre
	}
	
	@Test
	def unFilterTraeTodasLasRecetasDelRepositorioExternoYElAdapterLaConvierteCorrectamente(){
		var Collection<dds.grupo9.queComemos.Receta> recetas = newHashSet()
		recetas = repoExterno.filterRecetas
		Assert.assertEquals(12, recetas.size)
		Assert.assertEquals("canelones de ricota y verdura", recetas.head.nombre) // NOTA: mi adaptar ordena por nombre
		Assert.assertEquals(40, recetas.head.calorias)
	}

	@Test
	def unGetterTraeAlgunasRecetasSegunUnaBusquedaEnJsonYElAdapterLaConvierteCorrectamente(){
		val busquedaRecetas = new BusquedaRecetas()
		var Collection<dds.grupo9.queComemos.Receta> recetasDevueltas = newHashSet()
		busquedaRecetas.nombre = "ensalada lechuga agridulce"
		busquedaRecetas.dificultad = Dificultad.MEDIANA
		repoExterno.busquedaRecetas = busquedaRecetas
		recetasDevueltas = repoExterno.getRecetas()
		Assert.assertEquals("ensalada lechuga agridulce", recetasDevueltas.head.nombre)
		Assert.assertEquals(Dificultad.MEDIANA,recetasDevueltas.head.dificultad)
		Assert.assertEquals(4,recetasDevueltas.head.ingredientes.size)
	}
	
	/*@Test
	def unRepoExternoAdapterConvierteUnStringSimpleEnUnAPreferencia(){
		var String stringConEspacios = "carne"
		var RepoExternoAdapter adaptador = new RepoExternoAdapter()
		var Preferencia preferencia = adaptador.adaptarNombreIngrediente(stringConEspacios)
		Assert.assertEquals(Preferencia.CARNE, preferencia)
	}*/ // Ya no tiene sentido en el refactor dejamos de usar el enum Preferencia
	
	/*@Test
	def unRepoExternoAdapterConvierteUnStringConEspaciosEnUnAPreferencia(){
		var String stringConEspacios = "pure de tomate"
		var RepoExternoAdapter adaptador = new RepoExternoAdapter()
		var Preferencia preferencia = adaptador.adaptarNombreIngrediente(stringConEspacios)
		Assert.assertEquals(Preferencia.PURE_DE_TOMATE, preferencia)
	}*/ // Ya no tiene sentido en el refactor dejamos de usar el enum Preferencia
	
	@Test
	def unFilterTraeRecetasConElFormatoDeRecetasExternaYElAdapterLaConvierteCorrectamente(){
		val busquedaRecetas = new BusquedaRecetas()
		var Collection<dds.grupo9.queComemos.Receta> recetasDevueltas = newHashSet()
		busquedaRecetas.nombre = "ensalada lechuga agridulce"
		busquedaRecetas.dificultad = Dificultad.MEDIANA
		repoExterno.busquedaRecetas = busquedaRecetas
		recetasDevueltas = repoExterno.filterRecetas
		//println(repoExterno.filterRecetas())
		//println(repoExterno.filterRecetas().map[it.nombre])
		//println(repoExterno.filterRecetas().head)
		//println(repoExterno.filterRecetas().head.getNombre)
		Assert.assertEquals("ensalada lechuga agridulce",recetasDevueltas.head.nombre)
		Assert.assertEquals(Dificultad.MEDIANA,recetasDevueltas.head.dificultad)
		Assert.assertEquals(4,recetasDevueltas.head.ingredientes.size)
	}
	
	/* EL REPO DE LA CÁTEDRA TIENE UN ERROR POR EL CUAL CUANDO HACE EL BUILDER ASIGNA EL TIEMPO DE PREPARACIÓN COMO CARLORÍAS */
	@Test
	
	def void unaPersonaConSobrepesoConsultaTodasLasRecetasYNoObtieneLasQueTienenMasDe500Calorias(){
		val filtro = new ConsultaPorCaloriasMaximas(30)
		
		persona.setRepoRecetas(repoExterno)
		persona.peso = 120f
		persona.altura = 1.7f
		filtro.decorado = persona
		filtro.persona = persona
		
		Assert.assertEquals(41.52f, persona.imc, 0.05f)
		Assert.assertEquals(12, persona.recetasPropias.size)
		Assert.assertEquals(15, filtro.resultado.size)
	}
	
	@Test
	
	def void unaPersonaRealizaUnFiltroPorSusCondicionesPreexistentes(){
		
		val filtro = new ConsultaPorCondicionesPreexistentes()

		persona.agregarCondPreexistente(new Vegano())
		filtro.decorado = persona
		filtro.persona = persona
	
		Assert.assertEquals(21, filtro.resultado.size)
		//De las 12 recetas del repo externo una tiene un tipo de carne que por dominio no es recomendada para vegano
		//Se pueden incorporar fácilmente otras restricciones de carnes pero no por la consigna no están habilitadas
	}
	
	@Test
	
	def void unaPersonaNoObtieneComoResultadoDeLaBusquedaLasRecetasQueNoLeGustan(){
		val filtro = new ConsultaPorDisgusto()
		
		persona.agregarDisgusto("pescado")
		persona.agregarDisgusto("berberechos")
		persona.agregarDisgusto("bourbon")
		filtro.persona = persona
		filtro.decorado = persona
		
		Assert.assertEquals(21,filtro.resultado.size) 
		// De las 12 recetas del repo externo una tiene berberechos y otra bourbon
	}
	
	@Test
	
	def void aUnaPersonaRataNoSeLeMuestranLasRecetasConIngredientesCaros(){
		val filtro = new ConsultaPorIngredientesCaros()

		filtro.persona = persona
		filtro.decorado = persona
		
		Assert.assertEquals(21, filtro.resultado.size)
		//De las 12 recetas, hay dos recetas del repoExterno con salmón
	}
	
	@Test
	
	def void unaPersonaPuedeCombinarVariosFiltrosDistintos(){
		val filtro1 = new ConsultaPorCondicionesPreexistentes()
		val filtro2 = new ConsultaPorIngredientesCaros()
		
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro1.persona = persona
		filtro2.persona = persona
		filtro1.decorado = persona
		filtro2.decorado = filtro1

		Assert.assertEquals(19, filtro2.resultado.size)
		// 24 recetas: 12 del repoExterno y 12 locales, 1 tiene lomo, 1 tiene sal, 1 caldo, 2 del repo tienen salmón
	}	

	@Test
	
	def void unaPersonaPuedeObtenerLosDiezPrimerosResultadosDeUnaBusqueda(){
		val filtro = new ConsultaPorCondicionesPreexistentes()
		
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val diezPrimeros = new ObtenerLosDiezPrimeros()
		busqueda.proceso = diezPrimeros

		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro.persona = persona
		filtro.decorado = persona
		
		Assert.assertEquals(10, busqueda.resultado.size)
	}
	
	@Test
	
	def void unaPersonaPuedeObtenerSoloLas8RecetasParesDeUnaBusquedaQueDevuelve15Resultados(){
		val filtro = new ConsultaPorCondicionesPreexistentes()
		
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val procesoPares = new ConsiderarRecetasPares()
		busqueda.proceso = procesoPares
		
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro.persona = persona
		filtro.decorado = persona
		
		Assert.assertEquals(11, busqueda.resultado.size)
		// 12 del RepoExterno + 12 internas - 2 que se filtan = 22. 
		// Vector arranca en 0 => [0,21] = 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
	}
	
	@Test
	
	def void unaPersonaPuedeOrdenarLosResultadosDeUnaBusquedaSegunSusCalorias(){
		val filtro = new ConsultaPorDisgusto()
		val criterioCal = new CriterioPorCalorias()
		
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val ordenar = new OrdenarPorCriterio(criterioCal)
		busqueda.proceso = ordenar
		
		persona.agregarCondPreexistente(new Hipertenso()) 
		persona.agregarDisgusto("pollo")
		persona.agregarDisgusto("sal")
		persona.agregarDisgusto("salmon")
		persona.agregarDisgusto("lechuga")	
		persona.agregarDisgusto("ajo")		
		persona.agregarDisgusto("papa")
		persona.agregarDisgusto("tomillo")
		persona.agregarDisgusto("albahaca")
		persona.agregarDisgusto("ricota")	
		persona.agregarDisgusto("alga")
		persona.agregarDisgusto("azucar")
		persona.agregarDisgusto("helado de chocolate")
		persona.agregarDisgusto("carne")
		persona.agregarDisgusto("pescado")
		persona.agregarDisgusto("lomo")		
		persona.agregarDisgusto("caldo")				
		filtro.persona = persona
		filtro.decorado = persona
	
		val recetasOrdenadas = #[receta6, receta7, receta8, receta9, receta12, receta11, receta10]
		Assert.assertEquals(busqueda.resultado, recetasOrdenadas)	
		// Filtramos por disgustos quedándonos sólo con las recetas que creamos en el test
		// Comparamos contra una collection ordenada de las mismas
	}
}