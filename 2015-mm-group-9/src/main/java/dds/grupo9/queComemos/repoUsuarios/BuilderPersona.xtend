package dds.grupo9.queComemos.repoUsuarios

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.GrupoDePersonas
import dds.grupo9.queComemos.repoRecetas.RepoRecetas
import java.util.Collection

class BuilderPersona {
	
	@Accessors Persona perfilUsuario
	@Accessors float peso = -1	/* Peso de un Usuario */
	@Accessors float altura	= -1	/* Altura de un Usuario */
	@Accessors String nombre = "sinNombre";	/* Nombre de un Usuario */
	@Accessors String sexo		/* Sexo de un Usuario: M/m: Masculino y F/f: Femenino */
	@Accessors long fechaNacimiento = -1		/* Fecha de nacimiento de un Usuario */
	var Collection<String> gustos = newHashSet() /* Gustos de un Usuario */
	var Collection<String> disgustos = newHashSet() /*Disgustos de un Usuario */
	var Collection<CondPreexistente> condicionesPreexistentes = newHashSet() /* Condicionantes de un Usuario */
	@Accessors String rutina = "sinRutina" /* Tipo de rutina que lleva a cabo el Usuario */
    var Collection<Receta> recetasPropias = newHashSet() /*Recetas de un Usuario */
    var Collection<GrupoDePersonas> grupos = newHashSet()
    @Accessors RepoRecetas repoRecetas
		
	
	def build(){
		perfilUsuario = new Persona()
		perfilUsuario.nombre = nombre
		perfilUsuario.peso = peso
		perfilUsuario.altura = altura
		perfilUsuario.sexo = sexo
		perfilUsuario.fechaNacimiento = fechaNacimiento
		perfilUsuario.rutina = rutina
		gustos.forEach[perfilUsuario.agregarPreferencia(it)]
		disgustos.forEach[perfilUsuario.agregarDisgusto(it)]
		condicionesPreexistentes.forEach[perfilUsuario.agregarCondPreexistente(it)]	
		perfilUsuario.agregarSusRecetas(recetasPropias)
		grupos.forEach[grupo| grupo.agregarAGrupo(perfilUsuario)]
		perfilUsuario.repoRecetas = repoRecetas
		return perfilUsuario
	}
	
	def asignarNombre(String unNombre) {
		nombre = unNombre
	}
	
	def asignarPeso(float unPeso) {
		peso = unPeso
	}
	
	def asignarAltura(float unaAltura) {
		altura = unaAltura
	}
	
	def asignarSexo(String unSexo) {
		sexo = unSexo
	}
	
	def asignarFechaNacimiento(long unaFechaNacimiento) {
		fechaNacimiento = unaFechaNacimiento
	}
	
	def asignarUnGusto(String unGusto) {
		gustos.add(unGusto)
	}
	
	def borrarGustos(){
		gustos = null
	}
	
	def asignarUnDisguto(String unGusto) {
		disgustos.add(unGusto)
	}
	
	def borrarDisgutos(){
		disgustos = newHashSet()
	}
	
	def asignarUnaCondicionPreexistente(CondPreexistente unaCondicion) {
		condicionesPreexistentes.add(unaCondicion)
	}
	
	def borrarCondicionesPreexistentes(){
		condicionesPreexistentes = newHashSet()
	}
	
	def asignarRutina(String unaRutina) {
		rutina = unaRutina
	}
	
	def asignarUnaRecetaPropia(Receta unaReceta) {
		recetasPropias.add(unaReceta)
	}
	
	def borrrarRecetasPropias(){
		recetasPropias = newHashSet()
	}
	
	def asignarUnGrupo(GrupoDePersonas unGrupo) {
		grupos.add(unGrupo)
	}
	
	def borrarGrupos(){
		grupos = newHashSet()
	}
	
	def asginarRepoRecetas(RepoRecetas unRepositorio) {
		repoRecetas = unRepositorio
	}
	 	
	
}
