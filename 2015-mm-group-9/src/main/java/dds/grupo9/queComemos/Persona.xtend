package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import dds.grupo9.queComemos.excepciones.NoEsValidoException
import dds.grupo9.queComemos.excepciones.NoLoPuedeModificarException
import dds.grupo9.queComemos.excepciones.NoPuedeAgregarException
import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarios
import dds.grupo9.queComemos.repoRecetas.RepoRecetas
import dds.grupo9.queComemos.consultas.ConsultaDecorada
import dds.grupo9.queComemos.consultas.Consulta
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Persona implements ConsultaDecorada {
	
	@Accessors float peso	/* Peso de un Usuario */
	@Accessors float altura		/* Altura de un Usuario */
	@Accessors String nombre	/* Nombre de un Usuario */
	@Accessors String sexo		/* Sexo de un Usuario: M/m: Masculino y F/f: Femenino */
	@Accessors long fechaNacimiento		/* Fecha de nacimiento de un Usuario */
	@Accessors var Collection<String> gustos = newHashSet() /* Gustos de un Usuario */
	@Accessors var Collection<String> disgustos = newHashSet() /*Disgustos de un Usuario */
	@Accessors var Collection<CondPreexistente> condicionesPreexistentes = newHashSet() /* Condicionantes de un Usuario */
	@Accessors String rutina /* Tipo de rutina que lleva a cabo el Usuario */
    @Accessors var Collection<Receta> recetasPropias = newHashSet() /*Recetas de un Usuario */
    @Accessors var Collection<GrupoDePersonas> grupos = newHashSet()
    @Accessors RepoRecetas repoRecetas
    @Accessors var Collection<Receta> recetasFavoritas = newHashSet()
    @Accessors RepoUsuarios repoUsuarios
    @Accessors String motivoRechazo
    @Accessors String mail 
    @Accessors int recibeMail
    @Accessors Receta recetaSeleccionada
    @Accessors String contrasegna
    @Accessors Collection <Receta> ultimasRecetasConsultadas = newHashSet()
    
	new (){
		this.incializarAtributos
	}
	
	new (RepoUsuarios repoUsuarios){
		this.incializarAtributos
		repoUsuarios.agregarAPendiente(this)
	}
	
	def incializarAtributos(){
		nombre = "sinNombre"
		fechaNacimiento = -1
		peso = -1
		altura = -1 
		rutina = "sinRutina"
		sexo = "sinSexo"
		recibeMail = 0
	}
	
	def getGustos(){
		this.gustos
	}
	
	def getDisgustos(){
		this.disgustos
	}
	
	def getRecetasPropias(){
		this.recetasPropias
		}
		
	def getRecetasFavoritas(){
		this.recetasFavoritas
	}	
	
	/*Entrega 0 */		
	def float imc(){		/* IMC: índice de masa corporal, calculado como (peso/estatura^2) */
		peso / (altura**2) as float
	}
	/*Entrega 1 */
	def usuarioValido(){ /* Verifica si una persona es un Usuario válido */
		(this.completaCamposObligatorios && 
			nombre.length > 4 && 
			condicionesPreexistentes.forall[condicion | condicion.verificaDatosSegunCondicion(this)] && 
			this.fechaValida(new Fecha()))
	}
	
	def sigueRutinaSaludable(){ /* Evalúa si un Usuario sigue o no una rutina saludable */
		(this.tieneImcPromedio && this.subsanaCondicionesPreexistentes)
	}
	
	def tieneImcPromedio(){ /* Evalúa si un Usuario tiene un índice de masa corporal promedio, que se da cuando el IMC está entre 18 y 30 */
		this.imc > 18 && this.imc < 30
	}
	
	def subsanaCondicionesPreexistentes(){ /* Evalúa si para cada una de las condiciones preexistentes la misma se encuentra subsanada */
		condicionesPreexistentes.forall[condicion | condicion.subsanaCondicion(gustos, rutina, peso)]
	}
	
	def agregarCondPreexistente(CondPreexistente condicion){ /* Agrega una condicion preexistente a la colección */
		condicionesPreexistentes.add(condicion)
	}
	
	def agregarPreferencia(String preferencia){ /* Agrega una preferencia a la colección */
		gustos.add(preferencia)
	}
	
	
	def agregarDisgusto(String preferencia){ /* Agrega una preferencia a la colección */
		disgustos.add(preferencia)
	}
	
	
	def void agregarReceta(Receta receta){ /*Agrega una receta a la colección si cumple con las condiciones */
	    if(receta.recetaValida)
	     
	     recetasPropias.add(receta)
	 	
	 	else throw new NoEsValidoException("La receta no es válida")
	}
	
	def recetaNoRecomendada(Receta receta){ /* Evalúa si dada una receta, esta es recomendada para la persona o no */
		condicionesPreexistentes.exists[c|c.recetaNoRecomendada(receta)]
	}
	
	def modificarReceta (Receta receta, Modificacion modificacion){
		if(receta.puedeVerOModificarReceta(this)){
			receta.sufrirCambios(this, modificacion)
		}
		else throw new NoLoPuedeModificarException("No puede modificar esta receta")
	}
	
	def tienePreferencias() {
		gustos.length > 0
	}
	
	def indicaSexo() {
		sexo != "sinSexo"
	}
	
	def prefiereNoComer(Collection<Ingrediente> alimentos) {
		alimentos.forall[alimento| !(gustos.contains(alimento.nombre))]
	}
	
	def noLeDisguta(String unaPreferencia) {
		!disgustos.contains(unaPreferencia)
	}
	
	def fechaValida(Fecha fecha){
		fecha.actualizarFecha
		fecha.fechaDeHoy > fechaNacimiento
	}
	
	def completaCamposObligatorios(){
		(nombre != "sinNombre" && fechaNacimiento != -1 && peso != -1 && altura != -1 && rutina != "sinRutina")
	}
	
	def completarCamposObligatorios(String nombre, long fechaNacimiento, float peso, float altura, String rutina){
		this.nombre = nombre
		this.fechaNacimiento = fechaNacimiento
		this.peso = peso
		this.altura = altura
		this.rutina = rutina
	}
	
	def tieneXRecetasPropias(int cantidadRecetas) {
		recetasPropias.length == cantidadRecetas
	}
	

	def getReceta(String nombreReceta){
		(recetasPropias.findFirst[receta| receta.nombre == nombreReceta])
	}	
	
	def cantidadIngredientesReceta(String nombreReceta){
		getReceta(nombreReceta).cantidadIngredientes
	}
		
     /*Entrega 2 */
	def perteneceAUnGrupo(GrupoDePersonas grupo){
		grupos.contains(grupo)
	}
	
	def comparteGrupoCon(Persona persona) {
		grupos.exists[g|g.incluyeA(persona)] /*Podria ser también persona.perteneceAUnGrupo(g) */	
	}	
		
	def agregarGrupo(GrupoDePersonas grupo){
		grupos.add(grupo)
	}
	
	def recetasDeGrupo(){
		val Collection<Receta> listaDeRecetas= newHashSet
		grupos.forEach[g|listaDeRecetas.addAll(g.listarRecetasDeGrupo)]
		return listaDeRecetas
	}
	
	def recetasPublicas(){
		repoRecetas.getRecetas()
	}
	
	def void agregarSusRecetas(Collection<Receta> recetas){
		recetas.addAll(recetasPropias)
	}		 
	
	def listarTodasSusRecetas(){
		var listaDeRecetas = newHashSet()
		listaDeRecetas.addAll(recetasPropias)
		listaDeRecetas.addAll(recetasPublicas)
		listaDeRecetas.addAll(recetasDeGrupo)
		return listaDeRecetas
	}/*LA IDEA DE ESTE METODO ES PODER MANTENER VIGENTES TEST ANTERIORES*/
	 /*TAMBIEN SE BUSCA INCORPORAR EL REPO EXTERNO PARA NUEVOS TEST*/
	
	def marcarRecetaComoFavorita(Receta receta){/*agrega una receta a favoritos si puede verla */
		if(receta.puedeVerOModificarReceta(this))
		      recetasFavoritas.add(receta)
		      else throw new NoPuedeAgregarException("No se puede agregar la receta a favoritos")
	}
	def tieneRecetaFavorita(Receta receta){
		recetasFavoritas.contains(receta)
	}
	
	override Collection<Receta> resultado(){
		this.listarTodasSusRecetas		
	}
	
	override coleccionDeConsultas() {
		var Collection<Consulta> consultas = newHashSet();
		return consultas;
	}
	
	def tieneSobrepeso(int max){
		this.imc > max
	}
	
	/*Entrega 3 */
	
	def coincideNombre(Persona persona){
		
		this.nombre == persona.nombre
	}
	
	def coincidenCondiciones(Persona persona){
		
	   condicionesPreexistentes.containsAll(persona.condicionesPreexistentes)
		
	}
	
	def noContieneIngredientesQueLeDisgusten(Receta unaReceta){
		disgustos.forall[!unaReceta.tieneIngrediente(it)]
	}
	
	def esVegano(){
		condicionesPreexistentes.exists[it.esVeganismo()]
	}
	
	def setSexo(String sexo){
		this.sexo = sexo
	}
	
	def configurarParaRecibirMail(){
		this.recibeMail = 1
	}
	
	def estaConfiguradaParaRecibirMails(){
		this.recibeMail == 1
	}
}
	
