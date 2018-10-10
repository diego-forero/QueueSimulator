#settings es el array de instrucciones: settings[unique/multiple:simulationtype,:cashnumber,:simulationtime,:deltatime]

class supermarket

  attr_accessor :elapsedTime :shorterLine
  def initialize simulationtype:, cashnumber:, simulationtime:, deltatime: , elapsedtime:
    @simulationype= simulation_type
    @cashnumber=cash_number
    @simulationtime=simulation_time
    @deltatime=delta_time
  end

  def cashCreator
    attr_accessor cash_number:
    #@cashregister=Array.new
    #crear el arreglo de cajas que contendra los arreglos de filas que se crearan el numero de veces solitiado(cash_number.times) lines.each
    #hacer que: con el numero de cajas se cree un arreglo vacío que se vaya llenando con objetos de la clase Line (Line.new
    totalLines=Array.new(cash_number){Line.new}
  end

  def arrivalOfClients #este metodo seria de pasarlo a ambas clases hijo
    elapsedTime = 0
    while elapsedTime < simulationtime  do
    if elapsedTime % 3 = 0
      arrivedClients = Array.new(rand 5){Client.new}
      arrivedClients.length.times.totalLines[shorterArrayIndex].receive_client arrivedClients # hacer (la longitud del arreglo arrivedClients) veces el metodo receive_client sobre la linea mas corta (totalLines[shorterArrayIndex]) con la variable arrived clients para que borre el cliente
    end
    elapsedTime +=1
    end
    # #usar modulo para que %3!=0 (cada 3 minutos) se cumpla el arrived clientes
    # #@elapsedTime=
    # #se crea un arreglo de x clientes nuevos donde x es un rand de 0 a 5
    # arrivedClients = Array.new(rand 5){Client.new}

  end

  # private
  #   def clientInsertion
  #     #x<<y.delete_at(0)
  #     shorterLine
  #   end

end

class uniqueLine<supermarket
  # shorterLine=totalLines[0]
  shorterArrayIndex=0
end

class multipleLine<supermarket

  def shorterLineAnalysis
    initialize :shorterArrayIndex #se define variable para almacenar el index de la fila mas corta para ser usada en el clientInsertion
    #analisis para tener la
    #definir una variable shorterLine=0
    shorterArray=totalLines[0]
    totalLines.each_with_index do |comparisonLine, index|
      if totalLines[index].number_of_clients<shorterArray.number_of_clients
        shorterArray = comparisonLine
        shorterArrayIndex = index
      end
    end
  end

end
