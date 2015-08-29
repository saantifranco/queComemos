package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert

class GrupoTestSuite {
	@Test
	
	def void unGrupoTieneDosIntegrantesConDosRecetasCadaUnoEntoncesHay4RecetasDeGrupo(){
		val persona= new Persona
		val persona2 = new Persona
		val grupo = new GrupoDePersonas("Los Pibes")
		val receta = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(persona)
		val receta3 = new RecetaSimple(persona2)
		val receta4 = new RecetaSimple(persona2)
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente("pollo",100))
		receta.calorias=500
		receta2.agregarIngrediente(new Ingrediente("pescado",100))
		receta2.calorias=1000
		receta3.agregarIngrediente(new Ingrediente("carne",100))
		receta3.calorias=1000
		receta4.agregarIngrediente(new Ingrediente("chori",100))
		receta4.calorias=750
		
		
		persona.agregarReceta(receta)
		persona.agregarReceta(receta2)
		persona2.agregarReceta(receta3)
		persona2.agregarReceta(receta4)
		
		grupo.listarRecetasDeGrupo()
		
		Assert.assertEquals(grupo.cantidadDeRecetas,4)
	}
	
	// ENTREGA 3 TEST		


}