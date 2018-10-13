load 'cashier.rb'
load 'client.rb'
load 'queue.rb'

class Market
  attr_reader :cashiers

  def initialize(number_of_cashiers:)
    create_cashiers number_of_cashiers
  end

  def receive_new_clients
    Array.new(rand 5) { Client.new }
  end
end

class MarketUniqueQueue < Market
  attr_reader :cashiers, :queue

  def create_cashiers(number_of_cashiers)
    @queue = Queue.new
    @cashiers = Array.new(number_of_cashiers) { Cashier.new(@queue) }
  end

  def put_new_clients_in_queue
    i = 0
    new_clients = receive_new_clients
    @queue.receive_client new_clients.shift while i < new_clients.size
  end

  def work
    @cashiers.each(&:work)
    @queue.count_wait_time_for_clients
  end
end

class MarketMultipleQueue < Market
  attr_reader :cashiers, :queues

  def create_cashiers(number_of_cashiers)
    @cashiers = []
    @queues = []
    i = 0
    while i < number_of_cashiers
      temp_queue = Queue.new
      @queues << temp_queue
      @cashiers << Cashier.new(temp_queue)
      i += 1
    end
  end

  def put_new_clients_in_queue
    i = 0
    new_clients = receive_new_clients
    while i < new_clients.size
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
    temporal_cashier
  end

  def work
    @cashiers.each do |c|
      c.work
      c.line.count_wait_time_for_clients
    end
  end
end
