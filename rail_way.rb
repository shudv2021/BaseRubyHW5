require_relative 'route.rb'
require_relative 'stations.rb'
require_relative 'pasangertrain.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passanger_carriage.rb'
require_relative 'cargotrain.rb'



class RailWay
  attr_accessor :total_stations, :total_routs, :total_trains, :total_carriages
  def initialize
    @total_stations = []
    @total_routs = []
    @total_trains = []
    @total_carriages = []

  end

  def station_by_name(station_name)
    @total_stations.each do |station|
      return station if station.station_name == station_name
    end
  end

  def train_by_num(train_num)
    @total_trains.each do |train|
      return train if train.train_num == train_num
    end
  end

  def carriage_by_num(carriage_num)
    @total_carriages.each do |carriage|
      return carriage if carriage.carr_num == carriage_num
    end
  end

  def seed
    start_stations = %w[Краснодар Ростов Воронеж Москва Владимир]
    start_stations.each { |station| @total_stations<<Station.new(station) }
    self.total_trains.push(CargoTrain.new(111))
    self.total_trains.push(CargoTrain.new(222))
    self.total_trains.push(PasangerTrain.new(333))
    self.total_trains.push(PasangerTrain.new(444))
    #Создаем вагоны
    self.total_carriages.push(CargoCarriage.new(99111))
    self.total_carriages.push(CargoCarriage.new(99222))
    self.total_carriages.push(PassangerCarriage.new(88111))
    self.total_carriages.push(PassangerCarriage.new(88222))
    #Создаем пробный маршрут
    self.total_routs << Route.new(self.total_stations[0], self.total_stations[4])
    self.total_routs[0].add_station(1, self.total_stations[1])
    self.total_routs[0].add_station(2, self.total_stations[2])
    self.total_routs[0].add_station(3, self.total_stations[3])
    #отправляем поезда по маршруту
    #self.total_trains.each { |train| puts train.train_num.class}
    self.train_by_num(111).sent_train(self.total_routs[0])
    self.train_by_num(222).sent_train(self.total_routs[0])
    self.train_by_num(333).sent_train(self.total_routs[0])
    self.train_by_num(444).sent_train(self.total_routs[0])

  end

end

#rr=RailWay.new

