package dds.grupo9.queComemos

import org.junit.Assert
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarios
import dds.grupo9.queComemos.excepciones.NoEsValidoException
import org.junit.Test
import dds.grupo9.queComemos.repoUsuarios.BuilderPersona
import dds.grupo9.queComemos.excepciones.NoLoTieneException
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.condicionPreexistente.Diabetico
import org.junit.Before

class RepoUsuariosTestSuite {
	// ENTREGA 3 TEST
	
    var RepoUsuarios repoUsuarios;
   	var BuilderPersona builder;
    var Diabetico diabetico;
    var Hipertenso hipertenso;
    var Persona juani;
    var Persona juani2;
	
	@Before
	def void setup(){
       	repoUsuarios = new RepoUsuarios()
       	builder = new BuilderPersona()
        diabetico = new Diabetico()
        hipertenso = new Hipertenso()
        	
        builder.asignarNombre("juani")
       	builder.asignarAltura(1.70f)
       	builder.asignarPeso(70f)
      	builder.asignarRutina("Crossfit")
       	builder.asignarFechaNacimiento(19901010)
      	builder.asignarSexo("Masculino")
       	juani = builder.build
       		
       	builder.asignarAltura(1.60f)
        builder.asignarPeso(75f)
        builder.asignarRutina("Atletismo")
   		juani2 = builder.build
	}
			
	  @Test (expected = NoEsValidoException)
	  
	  def void unaPersonaSolicitaElIngresoAlSistemaPeroEsUnUsuarioNoValido(){
	  	
	  	val repoUsuarios = new RepoUsuarios()
	  	
	  	val builder = new BuilderPersona()
	  	builder.asignarNombre("juani")
	  	repoUsuarios.solicitarIngreso(builder.build)
	  	
	  }
	
       @Test
       
       def void unaPersonaEsAceptadaPorElAdministradorYElRepoLaEncuentraPorSuNombre(){
     
       repoUsuarios.solicitarIngreso(juani)
       repoUsuarios.aceptarUsuario(juani)
       
       Assert.assertEquals(juani,repoUsuarios.get(juani))       
    }
    
     @Test
     
     def void unaPersonaEsRechazadaPorElAdministradorYElRepoLaGuardaComoRechazada(){

        repoUsuarios.solicitarIngreso(juani)
        repoUsuarios.rechazarUsuario(juani,"No cumple con los requisitos de peso mínimo")
        
        Assert.assertEquals(1,repoUsuarios.cantidadRechazados)  	
     }
     
     @Test
     
     def void seActualizanLosDatosDeUnaPersonaRegistradaEnElRepoYElRegistroDelRepoSufreLasModificaciones(){
     	
        repoUsuarios.solicitarIngreso(juani)
        repoUsuarios.aceptarUsuario(juani)
        
        var juaniActualizado = juani2
 
        repoUsuarios.update(juaniActualizado)
      
        Assert.assertEquals(juaniActualizado,repoUsuarios.get(juani))    
     }
   
    @Test (expected = NoLoTieneException)
    
    def void noSePuedenActualizarLosDatosDeUnaPersonaQueNoEsUnUsuarioRegistrado(){
        
        repoUsuarios.solicitarIngreso(juani)
        
        var juaniActualizado = juani2
       
        repoUsuarios.update(juaniActualizado)   
   }
   
	@Test
	def void seListanTodasLasPersonasConMismoNombreYDiabeticasRegistradas(){
   		
        juani.agregarPreferencia("carne")
   		juani.agregarCondPreexistente(diabetico)
   		repoUsuarios.solicitarIngreso(juani)
   		repoUsuarios.aceptarUsuario(juani)
   		
   		juani2.agregarPreferencia("pescado")
   		juani2.agregarCondPreexistente(diabetico)
   		repoUsuarios.solicitarIngreso(juani2)
   		repoUsuarios.aceptarUsuario(juani2)
   		
   		builder.asignarAltura(1.82f)
   		builder.asignarPeso(72f)
   		builder.asignarRutina("Crossfit")
   		builder.asignarUnGusto("chori")
   		builder.borrarCondicionesPreexistentes
   		builder.asignarUnaCondicionPreexistente(hipertenso)
   		var juani3 = builder.build
   		repoUsuarios.solicitarIngreso(juani3)
   		repoUsuarios.aceptarUsuario(juani3)

   		Assert.assertEquals(2, repoUsuarios.list(juani).size)
   }
   
   	@Test
	def void seListanTodasLasPersonasConMismoNombreSinImportarLaCondicionPreexistentePorqueElPrototipoNoTieneNinguna(){
   		
   		repoUsuarios.solicitarIngreso(juani)
   		repoUsuarios.aceptarUsuario(juani)
   		
   		repoUsuarios.solicitarIngreso(juani2)
   		repoUsuarios.aceptarUsuario(juani2)

   		Assert.assertEquals(2,repoUsuarios.list(juani).size)
   }
}