package dds.grupo9.queComemos.applicationModels

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarioEjemplo

@Observable
@Accessors

class LogueoAppModel {
	
 	Persona persona
 	String contrasegna 
 	RepoUsuarioEjemplo repoUsuarios
 	
 	new(){
 		repoUsuarios = new RepoUsuarioEjemplo
 		persona = new Persona
 		contrasegna = "sinContrasegna"
 	}
	
	def Persona personaBuscada(){
		repoUsuarios.get(persona)
	}
}