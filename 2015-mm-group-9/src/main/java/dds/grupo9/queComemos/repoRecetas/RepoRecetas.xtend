package dds.grupo9.queComemos.repoRecetas

import dds.grupo9.queComemos.Receta
import java.util.Collection

interface RepoRecetas {
	def Collection<Receta> getRecetas()
}