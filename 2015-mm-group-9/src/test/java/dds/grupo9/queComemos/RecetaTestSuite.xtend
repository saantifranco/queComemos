package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.excepciones.NoEsValidoException
import dds.grupo9.queComemos.modificacionRecetas.modAgregarIngredientes
import dds.grupo9.queComemos.modificacionRecetas.modEliminarIngredientes
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import org.junit.Before

class RecetaTestSuite {
	
	var RecetaSimple receta;
	var RecetaSimple receta2;
	var RecetaSimple receta3;
	var RecetaSimple recetaDePersona;
	var RecetaCompuesta recetaCompuesta;
	var RepoRecetasPropio repositorioPropio;
	var Persona persona;
	var Persona persona2;
	
	@Before
	def void setup(){
		
		receta = new RecetaSimple(repositorioPropio)
		receta2 = new RecetaSimple(repositorioPropio)
		receta3 = new RecetaSimple(repositorioPropio)
		recetaCompuesta = new RecetaCompuesta(repositorioPropio)
		repositorioPropio = new RepoRecetasPropio()
		persona = new Persona()
		recetaDePersona = new RecetaSimple(persona)
		persona2 = new Persona()
	}
	
	@Test
	
	def void unaRecetaEsValida(){
		
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=3000
		
		Assert.assertTrue(receta.recetaValida)
	}
	
	@Test
	def void unaRecetaTieneCarneYAzucarYSal(){

		receta.agregarIngrediente(new Ingrediente("azucar", 150))
		receta.agregarIngrediente(new Ingrediente("sal", 15))
		receta.agregarIngrediente(new Ingrediente("carne", 300))
		
		receta.calorias=500
				
		Assert.assertTrue(receta.tieneIngrediente("carne"))	
		Assert.assertTrue(receta.tieneIngrediente("sal"))	
		Assert.assertTrue(receta.tieneIngrediente("azucar"))	
	}
	
	
	
	@Test
	
	def void unaPersonaPuedeVerOModificarUnaRecetaDada(){
		
		persona.nombre = "jose"
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias = 3000
		persona.agregarReceta(receta)
		
		Assert.assertTrue(recetaDePersona.puedeVerOModificarReceta(persona))
		
	}
	
	@Test
	
	def void unaPersonaNoPuedeModificarLaRecetaPrivadaDeOtra(){
	
		val otraPersona = persona2
		
		Assert.assertFalse(recetaDePersona.puedeVerOModificarReceta(otraPersona))
		
	}
		
	@Test
	
	def void unaPersonaPuedeModificarUnaRecetaPublica(){
		
		Assert.assertTrue(receta.puedeVerOModificarReceta(persona))
	}
		
	@Test
	
	def void unaPersonaQueAgregaIngredienteAUnaRecetaPropiaLograModificarlaSinGenerarUnaCopia(){

		var modificacion = new modAgregarIngredientes()
		recetaDePersona.agregarIngrediente(new Ingrediente ("papa",100))
		modificacion.ingrediente = new Ingrediente("sal", 10)
		recetaDePersona.calorias=400
		
		persona.modificarReceta(recetaDePersona,modificacion)
		
		Assert.assertEquals(recetaDePersona.cantidadIngredientes(), 2)
	}
	
	@Test
	
	def void unaPersonaQueEliminaIngredienteAUnaRecetaPropiaLograModificarlaSinGenerarUnaCopia(){
		
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente("papa",100)
		val sal = new Ingrediente("sal",10)
		recetaDePersona.agregarIngrediente(papa)
		recetaDePersona.agregarIngrediente(sal)
		recetaDePersona.calorias=400
		
		modificacion.ingrediente = new Ingrediente("sal")
		/* Nótese que no es necesario conocer exactamente el objeto ingrediente a eliminar, sino solo el nombre */
		
		persona.modificarReceta(recetaDePersona, modificacion)
		
		Assert.assertEquals(recetaDePersona.cantidadIngredientes(), 1)
	}
	
	@Test
	
	def void unaPersonaQueModificaUnaRecetaPublicaIncorporaComoPropiaUnaReceta(){
		
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente("papa",100)
		val sal = new Ingrediente("sal",10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(sal)
		receta.calorias=400
		
		modificacion.ingrediente = new Ingrediente("sal")
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
	}	

	@Test
	
	def void unaPersonaQueEliminaIngredienteDeUnaRecetaPublicaIncorporaComoPropiaUnaRecetaConMenosIngredientes(){
		
		receta.nombre = "papasALaCrema"
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente("papa",100)
		val crema = new Ingrediente("crema",25)
		val sal = new Ingrediente("sal",10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(crema)
		receta.agregarIngrediente(sal)
		receta.calorias=600
		
		modificacion.ingrediente = new Ingrediente("sal")
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
		Assert.assertEquals(2, persona.cantidadIngredientesReceta("papasALaCrema"))
	}
	
		@Test
	
	def void unaPersonaQueAgregaIngredienteDeUnaRecetaPublicaIncorporaComoPropiaUnaRecetaConMasIngredientes(){

		receta.nombre = "papasALaCrema"
		val modificacion = new modAgregarIngredientes()
		val papa = new Ingrediente("papa",100)
		val crema = new Ingrediente("crema",25)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(crema)
		receta.calorias=600
		
		modificacion.ingrediente = new Ingrediente("sal",10)
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
		Assert.assertEquals(3, persona.cantidadIngredientesReceta("papasALaCrema"))
	}
	
	
	@Test (expected = NoEsValidoException)
	
	def void unaRecetaSimpleNoPuedeTenerSubrecetas(){
		
		receta.agregarIngrediente(new Ingrediente("pollo", 1))
		receta2.agregarIngrediente(new Ingrediente("papa", 8))
		
		receta.agregarSubreceta(receta2)
		
		Assert.assertTrue(receta.tieneIngrediente("papa"))
	}
	
	@Test
	
	def void unaRecetaCompuestaReutilizaDosRecetasSimples(){

		receta.agregarIngrediente(new Ingrediente("pollo", 1))
		receta.agregarIngrediente(new Ingrediente("oregano", 10))
		receta2.agregarIngrediente(new Ingrediente("papa", 5))
		receta2.agregarIngrediente(new Ingrediente("manteca", 1))
		
		recetaCompuesta.agregarSubreceta(receta)
		recetaCompuesta.agregarSubreceta(receta2)
		
		Assert.assertTrue(recetaCompuesta.tieneIngrediente("pollo"))		
		Assert.assertTrue(recetaCompuesta.tieneIngrediente("oregano"))
		Assert.assertTrue(recetaCompuesta.tieneIngrediente("papa"))
		Assert.assertTrue(recetaCompuesta.tieneIngrediente("manteca"))

	}	
	
	@Test
	
	def void unaRecetaCompuestaReutilizaUnaRecetaSimpleYOtraCompuesta(){
		
		var recetaCompuestaNivel2 = new RecetaCompuesta(repositorioPropio)

		receta.agregarIngrediente(new Ingrediente("pollo", 1))
		receta.agregarIngrediente(new Ingrediente("oregano", 10))
		receta2.agregarIngrediente(new Ingrediente("papa", 5))
		receta2.agregarIngrediente(new Ingrediente("manteca", 1))
		receta3.agregarIngrediente(new Ingrediente("arroz", 5))
		receta3.agregarIngrediente(new Ingrediente("salsa de soja", 1))
		
		recetaCompuesta.agregarSubreceta(receta)
		recetaCompuesta.agregarSubreceta(receta2)
		
		recetaCompuestaNivel2.agregarSubreceta(recetaCompuesta)
		recetaCompuestaNivel2.agregarSubreceta(receta3)
		
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("pollo"))		
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("oregano"))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("papa"))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("manteca"))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("arroz"))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("salsa de soja"))

	}
		
	
		
	@Test
	
	def unaPersonaPuedeVerLaRecetaDeUnCompañeroDeGrupo(){
		val grupo = new GrupoDePersonas("Los Pibes")
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		recetaDePersona.agregarIngrediente(new Ingrediente("sal",10))
		recetaDePersona.agregarIngrediente(new Ingrediente("carne",100))
		recetaDePersona.calorias=150
		
		Assert.assertTrue(recetaDePersona.puedeVerOModificarReceta(persona2))
		
	}
	
	@Test
	
	def unaRecetaQueNoContieneIngredientesQueLeDisgutenAUnaPersonaNiIngredientesQueNoSeanPermitidosPorSusCondicionesPreexistentesPuedeSerSugeridaAEsaPersona(){	
		persona.nombre = "Paul"
		persona.agregarCondPreexistente(new Vegano)
		persona.agregarDisgusto("carne")
		receta.agregarIngrediente(new Ingrediente("papa",100))
		receta.agregarIngrediente(new Ingrediente("sal",10))
		
		Assert.assertTrue(receta.puedeSerSugeridaA(persona))	
		
	}			
	
	@Test

	def unaRecetaQueContieneIngredientesQueLeDisgutenAUnaPersonaNoPuedeSerSurgeridaAEsaPersona(){
		persona.nombre = "Paul"
		persona.agregarCondPreexistente(new Vegano)
		persona.agregarDisgusto("papa")
		receta.agregarIngrediente(new Ingrediente("papa",100))
		receta.agregarIngrediente(new Ingrediente("sal",10))
		
		Assert.assertFalse(receta.puedeSerSugeridaA(persona))
	}
	
	@Test
	def unaRecetaQueContieneIngredientesQueNoSeanPermitidosPorSusCondicionesPreexistentesNoPuedeSerSurgeridaAEsaPersona(){	
		persona.nombre = "Paul"
		persona.agregarCondPreexistente(new Hipertenso)
		persona.agregarDisgusto("carne")
		receta.agregarIngrediente(new Ingrediente("papa",100))
		receta.agregarIngrediente(new Ingrediente("sal",10))
		
		Assert.assertFalse(receta.puedeSerSugeridaA(persona))
	}	
	
	@Test
	def unaRecetaQueContieneAlgunIngredienteQueLeGusteAlGrupoYQueNoContieneIngredientesQueNoSeanPermitidosParaAlgunIntegrantePuedeSerSugeridaAUnGrupo(){	
		persona.agregarCondPreexistente(new Hipertenso)
		persona.agregarCondPreexistente(new Celiaco)
		val grupo = new GrupoDePersonas("Los Pibes")
		grupo.agregarPreferencia("carne")

		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente("papa",10))
		receta.agregarIngrediente(new Ingrediente("carne",100))
		
		Assert.assertTrue(receta.puedeSerSugeridaA(grupo))
	}	
			
	@Test
	def unaRecetaQueNoContieneNingunIngredienteQueLeGusteAlGrupoNoPuedeSerSugeridaAEseGrupo(){	
		persona.agregarCondPreexistente(new Hipertenso)
		persona.agregarCondPreexistente(new Celiaco)
		val grupo = new GrupoDePersonas("Los Pibes")
		grupo.agregarPreferencia("pollo")
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente("papa",10))
		receta.agregarIngrediente(new Ingrediente("carne",100))
		
		Assert.assertFalse(receta.puedeSerSugeridaA(grupo))
	}
	
	@Test
	def unaRecetaQueContieneIngredientesQueNoSeanPermitidosParaAlgunIntegranteDelGrupoNoPuedeSerSugeridaAEseGrupo(){	
		persona.agregarCondPreexistente(new Hipertenso)
		persona.agregarCondPreexistente(new Celiaco)
		val grupo = new GrupoDePersonas("Los Pibes")
		grupo.agregarPreferencia("carne")
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente("sal",10))
		receta.agregarIngrediente(new Ingrediente("carne",100))
		
		Assert.assertFalse(receta.puedeSerSugeridaA(grupo))	
	}	
	
}
	

	
		
	
