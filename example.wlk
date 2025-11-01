class Hogar {
  var nivelDeMugre
  const nivelDeConfort 
  
  method esBueno() = nivelDeMugre >= nivelDeConfort/2

  method recibirAtaque(plaga){
    nivelDeMugre = plaga.nivelDeDanio()
  }

}

class Huerta {
  var capacidadDeProduccion
  
  method esBueno() = capacidadDeProduccion > nivelHuerta.nivel()

  method recibirAtaque(plaga){
    capacidadDeProduccion = capacidadDeProduccion - (plaga.nivelDeDanio() * 0.1)
    if (plaga.trasmiteEnfermedades()){
      capacidadDeProduccion = capacidadDeProduccion - 10
    }
  }
}

object nivelHuerta {
  var property  nivel = 10
}


class Mascota {
  var salud = 400
  method esBueno() = salud > 250
  method recibirAtaque(plaga){
    if (plaga.trasmiteEnfermedades()){
      salud = salud - plaga.nivelDeDanio()
    }
  }
}

class Barrio {
  const elementos = []
  method agregarElemento(nuevoElemento){
    elementos.add(nuevoElemento)
  }
  method esCopado() {
    const lista1 = elementos.filter({e => e.esBueno()})
    const lista2 = elementos.filter({e => not e.esBueno()})
    
    return lista1.size() > lista2.size()
  }
}
//PLAGAS
class Plaga {
  var poblacion
  method trasmitirEnfermedades() =  poblacion >= 10
  method atacar(elemento){
    elemento.recibirAtaque(self)
    poblacion = poblacion * 0.1
  }
  method efectos(){
    poblacion = poblacion * 0.1
  }
}

class Cucaracha inherits Plaga{
  const pesoPromedio
  method nivelDeDanio() = poblacion/2
  //inherits = hereda de
  //override = anula
  //override indica que le haga caso al nuevo metodo no al padre
  //super() llama al elemento padre 
  override method trasmitirEnfermedades() =  super() && (pesoPromedio >= 10)
  
  override method efectos(){
    super()
    poblacion = poblacion + 2
  }
}

class Pulga inherits Plaga{
  method nivelDeDanio() = poblacion * 2 
}

class Garrapata inherits Pulga  {
  //hereda de la pulga el danio
  //hereda de la pulga trasmitirenfermedades
  //LOOKUP simpre mira el method hacia arriba
  override method efectos() {
    super()
    poblacion = poblacion * 0.2
  }  
  
}

class Mosquito inherits Plaga {
  method nivelDeDanio() = poblacion
  override method trasmitirEnfermedades() = super() && (poblacion % 3 == 0)
  
}