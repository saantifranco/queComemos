package dds.grupo9.queComemos.repoUsuarios

import java.util.Collection
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.excepciones.NoLoTieneException
import dds.grupo9.queComemos.excepciones.NoEsValidoException

class RepoUsuarios {
	
	var Collection<Persona> usuariosRegistrados = newHashSet()
	var Collection<Persona> pendientes = newHashSet
	var Collection <Persona> rechazados = newHashSet
	
	def add(Persona persona){
		usuariosRegistrados.add(persona)
	}
	
	def remove(Persona persona){
		if(contieneUsuario(persona))
		usuariosRegistrados.remove(persona)
		else throw new NoLoTieneException ("El usuario no está registrado")
	}
	
	def update(Persona persona){
		if(contieneUsuario(buscarPersonaPorNombre(persona))){
			usuariosRegistrados.remove(buscarPersonaPorNombre(persona))
			add(persona)
		}
		else throw new NoLoTieneException("El usuario no está registrado")
	}
	
	def get(Persona persona){
	    buscarPersonaPorNombre(persona)
	}
	
	def list(Persona persona){
	    filtrarListaPorNombreYCondiciones(persona)
	}
	
	def agregarAPendiente(Persona persona){
		pendientes.add(persona)
	}
	
	def aceptarUsuario(Persona persona){
		if(estaEnPendientes(persona)){
	    pendientes.remove(persona)
		add(persona)
		persona.repoUsuarios = this
		}
		else throw new NoLoTieneException("El usuario ingresado no se encuentra en lista de pendientes")
	}
	
	def rechazarUsuario(Persona persona, String motivo){
		if(estaEnPendientes(persona)){
			pendientes.remove(persona)
			persona.motivoRechazo= motivo
			rechazados.add(persona)
			
		}
	}
	
	def Persona buscarPersonaPorNombre(Persona persona){
		var usuarionuevo = new Persona()
		usuarionuevo = usuariosRegistrados.findFirst[usuario|usuario.coincideNombre(persona)]
		return usuarionuevo
	}
		
	def filtrarListaPorNombreYCondiciones(Persona persona){
	 	usuariosRegistrados.filter[usuario|usuario.coincidenCondiciones(persona)].filter[usuario|usuario.coincideNombre(persona)]
	}
	 
	def contieneUsuario(Persona persona){
		usuariosRegistrados.contains(persona)
	} 	
	
	def estaEnPendientes(Persona persona){
		pendientes.contains(persona)
	}
	
	def cantidadDeUsuariosRegistrados(){
		return usuariosRegistrados.size
	}
	
	def cantidadRechazados(){
		return rechazados.size
	}
	
	def solicitarIngreso(Persona perfilUsuario){
		if(perfilUsuario.usuarioValido) this.agregarAPendiente(perfilUsuario)
		else throw new NoEsValidoException("El perfil que desea generar no corresponde a un usuario valido")
	}
}