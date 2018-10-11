class Supermarket
  attr_reader :cashiers

  def initialize number_of_cashiers:
    create_cashiers number_of_cashiers
  end

  def create_cashiers number_of_cashiers
  end

  def receive_new_clients
    Array.new(rand 5){Client.new}
  end

  def put_new_clients_in_queue
  end

  def work
  end
end

class Supermarket_unique_queue < Supermarket
  attr_reader :cashiers

  def create_cashiers number_of_cashiers
    unique_queue = Queue.new
    @cashiers =  Array.new(number_of_cashiers) {Cashier.new (unique_queue)}
  end

  def put_new_clients_in_queue
    i = 0
    new_clients = receive_new_clients
    while i < new_clients.size  do
      @cashiers[0].line.receive_client new_clients.shift
    end
  end

  def work
    @cashiers.each {|c| c.work}
    @cashiers[0].line.count_wait_time_for_clients
  end
end

class Supermarket_multiple_queue < Supermarket
  attr_reader :cashiers

  def create_cashiers number_of_cashiers
    @cashiers =  Array.new(number_of_cashiers) {Cashier.new (Queue.new)}
  end

  def put_new_clients_in_queue
    i = 0
    new_clients = receive_new_clients
    while i < new_clients.size  do
      cashier_with_shortest_line.line.receive_client new_clients.shift
    end
  end

  def cashier_with_shortest_line
    temporal_cashier = @cashiers[0]
    @cashiers.each do |c|
      if temporal_cashier.line.number_of_clients > c.line.number_of_clients
        temporal_cashier = c
      end
    end
    return temporal_cashier
  end

  def work
    @cashiers.each do |c|
      c.work
      c.line.count_wait_time_for_clients
    end
  end

end
