package dds.grupo9.queComemos

import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadasPorSexo
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import java.util.Collection
import org.junit.Test
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import dds.grupo9.queComemos.monitoreoDeConsultas.VeganosQueConsultanRecetasDificiles
import dds.grupo9.queComemos.repoRecetas.RepoRecetasExterno
import java.util.Calendar
import dds.grupo9.queComemos.monitoreoDeConsultas.ConsultasPorHora
import org.junit.Before
import dds.grupo9.queComemos.consultas.ConsultaPorIngredientesCaros
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.consultas.ConsultaPorDisgusto
import dds.grupo9.queComemos.manejoResultadosConsultas.Busqueda

class MonitoreoDeConsultasTestSuite {
	
	var RepoRecetasPropio repositorioPropio;
	var Persona persona;
	var Persona persona2;
	var Persona persona3;
	var Persona persona4;
	var ConsultaPorIngredientesCaros filtro;
	var ConsultaPorCondicionesPreexistentes filtro2;
	var ConsultaPorDisgusto filtro3;
	var ConsultaPorDisgusto filtro4;
	var Busqueda busqueda1;
	var Busqueda busqueda2;
	var Busqueda busqueda3;
	var Busqueda busqueda4;
	var RecetaSimple receta1;
	var RecetaSimple receta2;
	var RecetaSimple receta3;
	var RecetaSimple receta4;
	var RecetaSimple receta5;
	
	
	@Before
	def void setup(){
		persona = new Persona()
		persona2 = new Persona()				
		persona3 = new Persona()
		persona4 = new Persona()
		persona.setSexo("M")
		persona2.setSexo("F")
		persona3.setSexo("m")
		persona4.setSexo("f")
		filtro = new ConsultaPorIngredientesCaros()
		filtro2 = new ConsultaPorCondicionesPreexistentes()
		filtro3 = new ConsultaPorDisgusto()
		filtro4 = new ConsultaPorDisgusto()
		
		
		busqueda1 = new Busqueda()
		busqueda1.fuenteDeDatos = filtro
		busqueda1.persona = persona
		busqueda2 = new Busqueda()
		busqueda2.fuenteDeDatos = filtro2
		busqueda2.persona = persona2
		busqueda3 = new Busqueda()
		busqueda3.fuenteDeDatos = filtro3
		busqueda3.persona = persona3
		busqueda4 = new Busqueda()
		busqueda4.fuenteDeDatos = filtro4
		busqueda4.persona = persona4
		
		filtro.persona = persona
		filtro.decorado = persona
		filtro2.persona = persona2
		filtro2.decorado = persona2
		filtro3.persona = persona3
		filtro3.decorado = persona3
		filtro4.persona = persona4
		filtro4.decorado = persona4
		
		repositorioPropio = new RepoRecetasPropio()
		persona.setRepoRecetas(repositorioPropio)
		persona2.setRepoRecetas(repositorioPropio)
		persona3.setRepoRecetas(repositorioPropio)
		persona4.setRepoRecetas(repositorioPropio)
		
		receta1 = new RecetaSimple(repositorioPropio)
		receta2 = new RecetaSimple(repositorioPropio)
		receta3 = new RecetaSimple(repositorioPropio)
		receta4 = new RecetaSimple(repositorioPropio)
		receta5 = new RecetaSimple(repositorioPropio)
		receta1.agregarIngrediente(new Ingrediente("pollo"))
		receta1.calorias = 650
		receta1.nombre = "Pollo a la parrilla"
		receta2.agregarIngrediente(new Ingrediente("salmon"))
		receta2.calorias = 420
		receta2.nombre = "Sushi"
		receta3.agregarIngrediente(new Ingrediente("lechuga"))
		receta3.calorias = 300
		receta3.nombre = "Ensalada Cesar"
		receta4.agregarIngrediente(new Ingrediente("huevo"))
		receta4.calorias = 550
		receta4.nombre = "Comidita"
		receta5.agregarIngrediente(new Ingrediente())
		receta5.calorias = 350
		receta5.nombre = "MacQueso"
		repositorioPropio.agregarRecetaPublica(receta1)
		repositorioPropio.agregarRecetaPublica(receta2)
		repositorioPropio.agregarRecetaPublica(receta3)
		repositorioPropio.agregarRecetaPublica(receta4)
		repositorioPropio.agregarRecetaPublica(receta5)
	}
	
	@Test
	
	def void saberCuantasConsultasSeHiceronEnUnaDeterminadaHora(){
		val repositorio = new RepoRecetasExterno()
		
		var consultasPorHora = new ConsultasPorHora()
		
		persona.setRepoRecetas(repositorio)
		persona2.setRepoRecetas(repositorio)
		persona3.setRepoRecetas(repositorio)
		persona2.agregarCondPreexistente(new Vegano())
		persona3.agregarDisgusto("mejillones")
		persona3.agregarDisgusto("ricota")
		persona3.agregarCondPreexistente(new Vegano())


		busqueda1.agregarMonitor(consultasPorHora)
		busqueda2.agregarMonitor(consultasPorHora)
		busqueda3.agregarMonitor(consultasPorHora)
				
		Assert.assertEquals(10, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(11, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(10, busqueda3.resultadoSinProcesar.size)
		
		Assert.assertEquals(3, consultasPorHora.obtenerConsultasPorHora(Calendar.getInstance().get(Calendar.HOUR_OF_DAY)))
	}
  
   @Test
	
	def void saberCuantosVeganosConsultaronRecetasDificiles(){
		val repositorio = new RepoRecetasExterno()

		var veganosDificiles = new VeganosQueConsultanRecetasDificiles()
		
		persona.setRepoRecetas(repositorio)
		persona2.setRepoRecetas(repositorio)
		persona3.setRepoRecetas(repositorio)
		persona2.agregarCondPreexistente(new Vegano())
		persona3.agregarDisgusto("mejillones")
		persona3.agregarDisgusto("ricota")
		persona3.agregarCondPreexistente(new Vegano())

		busqueda1.agregarMonitor(veganosDificiles)
		busqueda2.agregarMonitor(veganosDificiles)
		busqueda3.agregarMonitor(veganosDificiles)
		
		Assert.assertEquals(10, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(11, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(10, busqueda3.resultadoSinProcesar.size)
		
		Assert.assertEquals(1, veganosDificiles.cantidadDeVeganosQueConsultaronRecetasDificiles())
	}
   
   @Test
	
	def void obtenerLasRecetasMasConsultadasLuegoDeUnaSerieDeConsultas(){

		var recetasMC = new RecetasMasConsultadas()
		
		persona3.agregarDisgusto("salmon")
		persona3.agregarDisgusto("lechuga")
		persona2.agregarCondPreexistente(new Vegano())

		busqueda1.agregarMonitor(recetasMC)
		busqueda2.agregarMonitor(recetasMC)
		busqueda3.agregarMonitor(recetasMC)
		
		var Collection<String> recetasMasConsultadas = newHashSet()
		recetasMasConsultadas.addAll("MacQueso", "Comidita", "Pollo a la parrilla")
				
		Assert.assertEquals(4, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(3, busqueda3.resultadoSinProcesar.size)
		
		Assert.assertEquals(recetasMasConsultadas, recetasMC.recetasMasConsultadas(3))
	}	
	
	@Test
	
	def void obtenerLasRecetasMasConsultadasPorMujeresLuegoDeUnaSerieDeConsultas(){

		var recetasMCPS = new RecetasMasConsultadasPorSexo()
		
		persona3.agregarDisgusto("salmon")
		persona3.agregarDisgusto("lechuga")
		persona4.agregarDisgusto("huevo")
		persona2.agregarCondPreexistente(new Vegano())

		busqueda1.agregarMonitor(recetasMCPS)
		busqueda2.agregarMonitor(recetasMCPS)
		busqueda3.agregarMonitor(recetasMCPS)
		busqueda4.agregarMonitor(recetasMCPS)
							
		var recetasMasConsultadasPM = newHashSet()
		recetasMasConsultadasPM.addAll("MacQueso", "Ensalada Cesar", "Sushi")
		
		Assert.assertEquals(4, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(3, busqueda3.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda4.resultadoSinProcesar.size)
		
		Assert.assertEquals(recetasMasConsultadasPM, recetasMCPS.recetasMasConsultadasPorMujeres(3))
	}
	
	@Test
	
	def void obtenerLasRecetasMasConsultadasPorHombresLuegoDeUnaSerieDeConsultas(){

		var recetasMCPS = new RecetasMasConsultadasPorSexo()
		
		persona3.agregarDisgusto("salmon")
		persona3.agregarDisgusto("lechuga")
		persona4.agregarDisgusto("huevo")
		persona2.agregarCondPreexistente(new Vegano())
		
		busqueda1.agregarMonitor(recetasMCPS)
		busqueda2.agregarMonitor(recetasMCPS)
		busqueda3.agregarMonitor(recetasMCPS)
		busqueda4.agregarMonitor(recetasMCPS)
							
		var recetasMasConsultadasPH = newHashSet()
		recetasMasConsultadasPH.addAll("MacQueso", "Comidita", "Pollo a la parrilla")
		
		
		Assert.assertEquals(4, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(3, busqueda3.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda4.resultadoSinProcesar.size)
		
		Assert.assertEquals(recetasMasConsultadasPH, recetasMCPS.recetasMasConsultadasPorHombres(3))
		
	}
}