package dds.grupo9.queComemos.repoUsuarios

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo
import org.uqbar.commons.utils.Observable
import java.util.Collection

@Observable
class RepoUsuarioEjemplo extends RepoUsuarios {
	
	@Accessors BuilderPersona builder
	//@Accessors Collection<Persona> usuarios
	@Accessors Persona persona1
	@Accessors Persona persona2
	@Accessors Persona persona3
	@Accessors Persona persona4
	@Accessors Persona persona5
	@Accessors RepoRecetasEjemplo repositorioRecetas
	@Accessors Persona personaBuscada
	
	new(){
		//crear y configurar personas
		builder = new BuilderPersona
		this.repositorioRecetas = new RepoRecetasEjemplo
		builder.asignarAltura(1.70f)
       	builder.asignarPeso(70f)
      	builder.asignarRutina("Crossfit")
       	builder.asignarFechaNacimiento(19901010)
      	builder.asignarSexo("Masculino")
      	builder.repoRecetas = repositorioRecetas
		persona1 = builder.build
		persona2 = builder.build
		persona3 = builder.build
		persona4 = builder.build
		persona5 = builder.build
		persona1.nombre = "Juani"
		persona2.nombre = "Juampi"
		persona3.nombre = "Santi"
		persona4.nombre = "Dante"
		persona5.nombre = "Igna"
		
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.head)
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.last)
		
		persona2.marcarRecetaComoFavorita(persona2.repoRecetas.getRecetas.head)
		persona2.marcarRecetaComoFavorita(persona2.repoRecetas.getRecetas.last)
		
		persona3.marcarRecetaComoFavorita(persona3.repoRecetas.getRecetas.head)
		persona3.marcarRecetaComoFavorita(persona3.repoRecetas.getRecetas.last)
		
		persona4.marcarRecetaComoFavorita(persona4.repoRecetas.getRecetas.head)
		persona4.marcarRecetaComoFavorita(persona4.repoRecetas.getRecetas.last)
		
		persona5.marcarRecetaComoFavorita(persona5.repoRecetas.getRecetas.head)
		persona5.marcarRecetaComoFavorita(persona5.repoRecetas.getRecetas.last)
		
		this.add(persona1)
		this.add(persona2)
		this.add(persona3)
		this.add(persona4)
		this.add(persona5)
		personaBuscada = new Persona
	}

}