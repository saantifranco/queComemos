package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.condicionPreexistente.Diabetico
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.excepciones.NoEsValidoException
import dds.grupo9.queComemos.excepciones.NoPuedeAgregarException
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import org.junit.Before
import dds.grupo9.queComemos.consultas.ConsultaPorCaloriasMaximas

class PersonaTestSuite {
	
	var Persona persona;
	var Persona persona2;
	var RecetaSimple receta;
	var RecetaSimple receta2;
	var RecetaSimple receta3;
		
	@Before
	def void setup(){
		
		persona = new Persona()
		persona.peso = 74.0f
		persona.altura = 1.79f
		persona2 = new Persona()
		
		receta = new RecetaSimple(persona)
		receta2 = new RecetaSimple(persona)
		receta3 = new RecetaSimple(persona)
	}

	@Test
	def void unaPersonaIMC(){
		val santiago = new Persona()
		
		santiago.peso = 74.0f
		santiago.altura = 1.79f
		
		Assert.assertEquals(23.10f, santiago.imc, 0.05f)
	}
	
	@Test
	def void juaniIMC(){
		val juani = new Persona()
		
		juani.peso = 70.0f
		juani.altura = 1.82f
		
		Assert.assertEquals(21.13f, juani.imc, 0.05f)
		
	}
	
	@Test 
	def void ignacioIMC(){
	 	 val ignacio = new Persona()
	 	 
	 	 ignacio.peso = 78.0f
	 	 ignacio.altura = 1.72f
	 	 
	 	 Assert.assertEquals(26.36f, ignacio.imc, 0.05f)
	}
	
	@Test
	def void juanPabloIMC(){
		val juanPablo = new Persona()
		
		juanPablo.peso = 76.0f
		juanPablo.altura = 1.85f
		
		Assert.assertEquals(22.21f, juanPablo.imc, 0.01f)
	}
	
	@Test
	def void unaPersonaTieneImcPromedio(){
		Assert.assertTrue(persona.tieneImcPromedio)
	}
	
	@Test
	def void unaPersonaConImcPromedioNoTieneCondicionesPreexistentesYSigueRutinaSaludable(){
		Assert.assertTrue(persona.sigueRutinaSaludable)
	}
	
	@Test
	def void unaPersonaSinImcPromedioNoSigueRutinaSaludable(){
		persona.peso = 740.0f
		Assert.assertFalse(persona.sigueRutinaSaludable)
	}
	
	@Test
	def void unaPersonaConIMCPromedioYQueSubsanaTodasLasCondicionesPreexistentes(){
		persona.agregarCondPreexistente(new Vegano())
		persona.agregarCondPreexistente(new Hipertenso())
		persona.agregarCondPreexistente(new Diabetico())
		persona.agregarCondPreexistente(new Celiaco())
		
		persona.agregarPreferencia("fruta")
		persona.rutina = "INTENSIVO"

		Assert.assertTrue(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioYQueNoSubsanaHipertension(){
		persona.agregarCondPreexistente(new Hipertenso())

		persona.rutina = "LEVE"
		
		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioYQueNoSubsanaVeganismo(){
		persona.agregarCondPreexistente(new Vegano())

		persona.agregarPreferencia("verdura")
		
		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioYQueNoSubsanaDiabetes(){

		persona.agregarCondPreexistente(new Diabetico())
		
		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaAgregaUnaReceta(){
		val receta = new RecetaSimple(persona)
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=500
		persona.agregarReceta(receta)
		
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
		
	}
	
	@Test (expected = NoEsValidoException)
	
	def void unaPersonaNoPuedeAgregarUnaReceta(){
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=50000
		persona.agregarReceta(receta)
		
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
		
	}
	
	@Test
	def void unDiabeticoNoPuedeConsumirUnaRecetaConAzucar(){
		val azucar = new Ingrediente()
		val diabetico = new Diabetico()
		azucar.nombre = "azucar"
		azucar.cantidad = 150
		receta.agregarIngrediente(azucar)
		receta.calorias=500
		persona.agregarCondPreexistente(diabetico)
		
		Assert.assertTrue(persona.recetaNoRecomendada(receta))
	}
	
	
	
	@Test
	
	def void unVeganoYUnHipertensoNoPuedenConsumirUnaRecetaConSalYCarne(){
	    val vegano= new Vegano()
	    val hipertenso = new Hipertenso()
	    
	    receta.agregarIngrediente(new Ingrediente("sal",10))
	    receta.agregarIngrediente(new Ingrediente("carne",200))
	    
	    receta.calorias=400
	    
	    persona.agregarCondPreexistente(vegano)
	    persona.agregarCondPreexistente(hipertenso)
	    
	    Assert.assertTrue(persona.recetaNoRecomendada(receta))    	
	    
	}
	
	@Test
	def void unaRecetaConMuchaAzucarYSalYCarneSoloPuedeSerConsumidaPorUnCeliaco(){
		val celiaco = new Celiaco()
		
		receta.agregarIngrediente(new Ingrediente("azucar", 150))
		receta.agregarIngrediente(new Ingrediente("sal", 15))
		receta.agregarIngrediente(new Ingrediente("carne", 300))
		
		receta.calorias=500
		
		persona.agregarCondPreexistente(celiaco)
				

		Assert.assertFalse(persona.recetaNoRecomendada(receta))		
		

	}	

	
	@Test
	def void unaPersonaEsUnUsuarioValido()
	{
		persona.nombre = "El Enzo"
		persona.rutina = "INTENSIVO"
		persona.fechaNacimiento = 19611112
		persona.sexo = 'M'
		
		persona.agregarCondPreexistente(new Hipertenso())
		persona.agregarCondPreexistente(new Diabetico())
		persona.agregarCondPreexistente(new Vegano())
		persona.agregarCondPreexistente(new Celiaco())
		persona.agregarPreferencia("verdura")
		persona.agregarPreferencia("melon")
		
		Assert.assertTrue(persona.usuarioValido)
		
	}
	
	@Test
	def void unaPersonaNoCompletaTodosSusDatosBasicos()
	{
		persona.nombre = ""
		persona.rutina = "INTENSIVO"
		persona.fechaNacimiento = 19611112


		Assert.assertFalse(persona.usuarioValido)
		
	}

	@Test
	def void unaPersonaNacioDespuesDelDiaDeLaFecha()
	{
		persona.nombre = "El Enzo"
		persona.rutina = "INTENSIVO"
		persona.fechaNacimiento = 20201212
		persona.sexo = 'M'

		Assert.assertFalse(persona.usuarioValido)
		
	}	

	@Test
	def void unaPersonaNoIndicaSexo()
	{
		Assert.assertFalse(persona.indicaSexo)
	}	
	
	@Test
	def void unVeganoQuePrefiereComerCarneNoEsValido()
	{		
		persona.nombre = "El Enzo"
		persona.rutina = "INTENSIVO"
		persona.fechaNacimiento = 19611112
		persona.sexo = 'M'
		
		persona.agregarCondPreexistente(new Hipertenso())
		persona.agregarCondPreexistente(new Diabetico())
		persona.agregarCondPreexistente(new Vegano())
		persona.agregarCondPreexistente(new Celiaco())
		persona.agregarPreferencia("carne")
		persona.agregarPreferencia("melon")
		
		Assert.assertFalse(persona.usuarioValido)
		
		}
	
	/*@Test
	def void fecha()
	{
		var Fecha fecha = new Fecha()
		fecha.actualizarFecha
		Assert.assertEquals(20150416,fecha.fechaDeHoy)
		
	}*/

	
	@Test
	
	def void unaPersonaTieneEnSuListaDeRecetasTotalesUnaRecetaPropiaYUnaRecetaPublicaYUnaRecetaDeUnCompañeroDeGrupo(){
		val grupo = new GrupoDePersonas("Los Pibes")
	    grupo.agregarAGrupo(persona)
	    grupo.agregarAGrupo(persona2)
	    
	    val repositorio = new RepoRecetasPropio()
	    persona.setRepoRecetas(repositorio)
	    receta.agregarIngrediente(new Ingrediente("carne",100))
	    receta.calorias=500
	    persona.agregarReceta(receta)
	   	
	    val receta4= new RecetaSimple(repositorio)
	    receta4.agregarIngrediente(new Ingrediente("chori",100))
	    receta4.calorias=700
	    repositorio.agregarRecetaPublica(receta4)
	    
	   	val receta5 = new RecetaSimple(persona2)
	   	receta5.agregarIngrediente(new Ingrediente("pollo",100))
	    receta5.calorias=800
	   	persona2.agregarReceta(receta5)

	    Assert.assertEquals(3,persona.listarTodasSusRecetas.size)
	}
	
	@Test
	
	def void unaPersonaPuedeAgregarUnaRecetaComoFavoritayQuedaEnElHistorial(){
		val repositorio = new RepoRecetasPropio()
		persona.setRepoRecetas(repositorio)
		val recetaDelRepo = new RecetaSimple(repositorio)
		repositorio.agregarRecetaPublica(recetaDelRepo)
		
		persona.marcarRecetaComoFavorita(recetaDelRepo)
		
		Assert.assertTrue(persona.tieneRecetaFavorita(recetaDelRepo))
		
	}
	
	
	@Test 
	 
	 def void unaPersonaAgregaUnaRecetaPrivadaAFavoritos (){
           receta.agregarIngrediente(new Ingrediente())
		   receta.calorias=500
           val grupo = new GrupoDePersonas("amigos")
           
           grupo.agregarAGrupo(persona)
           grupo.agregarAGrupo(persona2)
		   persona.agregarReceta(receta) 
	 	   persona2.marcarRecetaComoFavorita(receta)
	 	   
	 	 Assert.assertEquals(persona2.getRecetasFavoritas.size,1)  
	 }
	    
	@Test (expected = NoPuedeAgregarException)
	
	def void unaPersonaQueNoPuedeVerNiModificarUnaRecetaNoPuedeAgregarlaComoFavoritaYSaltaExcepcion(){
		val receta = new RecetaSimple (persona2)
		persona.marcarRecetaComoFavorita(receta)
	}
	
	@Test 
     
   	def void unaPersonaConoceLasUltimasRecetasQueConsulto(){
   	
   		val consulta = new ConsultaPorCaloriasMaximas(10)
   		val repo = new RepoRecetasPropio()
   		val receta4 = new RecetaSimple(repo)
   		persona.setRepoRecetas(repo)
   	
   	
   		receta.calorias=1000
   		receta.agregarIngrediente(new Ingrediente)
   		receta2.calorias=100
   		receta2.agregarIngrediente(new Ingrediente)
   		receta3.calorias=300
   		receta3.agregarIngrediente(new Ingrediente)
   		receta4.calorias=1000
   		receta4.agregarIngrediente(new Ingrediente)
   	
   		persona.agregarReceta(receta)
   		persona.agregarReceta(receta2)
   		persona.agregarReceta(receta3)
   		repo.agregarRecetaPublica(receta4)
   	
   		consulta.persona = persona
   		consulta.decorado = persona
   		consulta.resultado
   	
   		Assert.assertEquals(2,persona.ultimasRecetasConsultadas.size)
   	
   	
   	
   } 
 
}
   
