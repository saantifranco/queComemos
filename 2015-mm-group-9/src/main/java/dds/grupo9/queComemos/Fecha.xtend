package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Calendar

class Fecha {
	@Accessors int year
	@Accessors int month
	@Accessors int day
	var Calendar calendario = Calendar.getInstance()
	var long fechaCompleta
	
	def actualizarFecha(){
		year = calendario.get(Calendar.YEAR);
		month = calendario.get(Calendar.MONTH) +  1
		day = calendario.get(Calendar.DATE)
	}
	
	def fechaDeHoy(){
		
		if(month>9){
			fechaCompleta = year * 1000 + month * 100 + day
		}
		else
		{
			fechaCompleta = year * 10000 + month * 100 + day
		}

		return fechaCompleta
	}
}