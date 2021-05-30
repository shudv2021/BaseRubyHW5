require_relative 'route.rb'
require_relative 'stations.rb'
require_relative 'pasanger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passanger_carriage.rb'

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

  def add_train(type, train_num)
    if type == '1'
      rr.total_trains.push(PasangerTrain.new(train_num))
      puts 'Создаем поезд'
      puts rr.total_trains.inspect
    elsif type == '2'
      rr.total_trains.push(CargoTrain.new(train_num))
    end
  end

  def show_all_rotes
    self.total_routs.each_with_index do |route, index|
      print " Маршрут #{index + 1}: "
      route.all_stations.each do |station|
        print " *#{station.station_name}* "
      end
      puts " \n_____________________________________ "
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

  def interface
    system 'clear'
    # По идеее  строка должна очищать поле вывода, но я вижу всю простыню сообщений после каждой операции
    puts ' Запущена программа железная дорога '
    puts ' 1.Создать станцию '
    puts ' 2.Показать все станции '
    puts ' 3.Показать все поезда на станции '
    puts ' 4.Создать поезд '
    puts ' 5.Создать маршрут '
    puts ' 6.Добавить станцию на маршрут '
    puts ' 7.Удалить станцию с маршрута '
    puts ' 8.Показать все маршруты'
    puts ' 9.Назначить поезду маршрут '
    puts ' 10.Добавить вагон к поезду '
    puts ' 11.Отцепить вагон от поезда '
    puts ' 12.Отправить поезд вперед '
    puts ' 13.Отправить поезд назад '
    puts ' 14.Выйти из программы'
    print ' Выберете действие: '
    action = gets.chomp

    case action
    when '1'
      puts 'Введите название станции:'
      station_name = gets.chomp
      self.total_stations.push(Station.new(station_name))
    when '2'
      self.total_stations.each { |station| puts station.station_name}
    when '3'
      print 'Введите название станции: '
      station = gets.chomp
      self.station_by_name(station).show_all_trains
    when '4'
      print ' Выберите тип новго поезда 1.Пассажирски/2.Грузовой: '
      type = gets.chomp
      print 'Введите номер поезда:'
      train_num = gets.chomp.to_i
      self.add_train(type, train_num)

    when '5'
      print 'Введите первую станцию маршрута'
      start_station = gets.chomp
      print ' Введите конечную станцию маршрута'
      finish_station = gets.chomp
      self.total_routs.push(Route.new(self.station_by_name(start_station), self.station_by_name(finish_station)))

    when '6'
      print ' Выберите номер изменяемого маршрута: '
      route_index = gets.chomp.to_i
      print ' Выберите положение станции (номер стенции на маршруте): '
      station_locat = gets.chomp.to_i
      print ' Введите станцию которую хотите добавить: '
      station_name = gets.chomp
      self.total_routs[route_index - 1].add_station(station_locat, self.station_by_name(station_name)).delete(nil )

    when '7'
      print ' Выберите номер изменяемого маршрута: '
      route_index = gets.chomp.to_i
      print ' Введите название удаляемой станции :'
      station_name = gets.chomp
      self.total_routs[route_index - 1].delete_station(self.station_by_name(station_name))

    when '8'
      self.show_all_rotes

    when '9'
      print 'Введите номер поезда: '
      train_num = gets.chomp.to_i
      print ' Введите номер маршрута: '
      route_index = gets.chomp.to_i
      self.train_by_num(train_num).sent_train(self.total_routs[route_index - 1])
    when '10'
      print 'Выберите поезд:'
      train_num = gets.chomp.to_i
      print 'Выберите вагон для довбавления:'
      carriage_num = gets.chomp.to_i
      self.train_by_num(train_num).add_carriage(self.carriage_by_num(carriage_num))
    when '11'
      print 'Выберите поезд:'
      train_num = gets.chomp.to_i
      self.train_by_num(train_num).unhook
    when '12'
      print 'Выберите поезд:'
      train_num = gets.chomp.to_i
      self.train_by_num(train_num).move_forvard
    when '13'
      print 'Выберите поезд:'
      train_num = gets.chomp.to_i
      self.train_by_num(train_num).move_back
    when '14'
      puts ' Программа железная дорога завершена.'
      exit
    end

  end

end

#rr=RailWay.new

