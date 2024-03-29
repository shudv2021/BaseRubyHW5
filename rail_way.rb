require_relative 'route.rb'
require_relative 'stations.rb'
require_relative 'pasanger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passanger_carriage.rb'

class RailWay


  def initialize
    @total_stations = []
    @total_routs = []
    @total_trains = []
    @total_carriages = []
  end
  #вне private потому что мы можем обращаться к методу из main.rb
  # возможнов в main его нужно будет отключить, а вместо него написать метод чтения из файла
  # а потом опять подключить
  def seed
    start_stations = %w[Краснодар Ростов Воронеж Москва Владимир]
    start_stations.each { |station| @total_stations<<Station.new(station) }
    total_trains.push(CargoTrain.new(111))
    total_trains.push(CargoTrain.new(222))
    total_trains.push(PasangerTrain.new(333))
    total_trains.push(PasangerTrain.new(444))
    #Создаем вагоны
    total_carriages.push(CargoCarriage.new(99111))
    total_carriages.push(CargoCarriage.new(99222))
    total_carriages.push(PassangerCarriage.new(88111))
    total_carriages.push(PassangerCarriage.new(88222))
    #Создаем пробный маршрут
    total_routs << Route.new(total_stations[0], total_stations[4])
    total_routs[0].add_station(1, total_stations[1])
    total_routs[0].add_station(2, total_stations[2])
    total_routs[0].add_station(3, total_stations[3])
    #отправляем поезда по маршруту
    #self.total_trains.each { |train| puts train.train_num.class}
    train_by_num(111).sent_train(total_routs[0])
    train_by_num(222).sent_train(total_routs[0])
    train_by_num(333).sent_train(total_routs[0])
    train_by_num(444).sent_train(total_routs[0])
  end

  def interface
    loop do
    system 'clear'
    # По идеее  строка должна очищать поле вывода, но я вижу всю простыню сообщений
    # после каждой операции
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
      create_station
    when '2'
      show_all_stations
    when '3'
      show_trains_on_starions
    when '4'
      create_train
    when '5'
      create_route
    when '6'
      add_station_on_route
    when '7'
      del_station_from_route
    when '8'
      self.show_all_rotes

    when '9'
      sent_train_by_route

    when '10'
      add_carriage_to_train

    when '11'
      del_carriage_from_train
    when '12'
      sent_train_forvard
    when '13'
      sent_train_back
    when '14'
      finished_all

    end
    end
  end

  private
  attr_accessor :total_stations, :total_routs, :total_trains, :total_carriages

  def create_station
    puts 'Введите название станции:'
    station_name = gets.chomp
    self.total_stations.push(Station.new(station_name))
  end

  def show_all_stations
    total_stations.each { |station| puts station.station_name}
  end

  def show_trains_on_starions
    print 'Введите название станции: '
    station = gets.chomp
    puts all_trains = station_by_name(station).return_all_trains
    puts "На станции #{station} находятся:"
    all_trains.each { |train| puts "*#{train.type}  Поезд №  #{train.train_num}*"}
  end

  def create_train
    print ' Выберите тип новго поезда 1.Пассажирски/2.Грузовой: '
    type = gets.chomp
    print 'Введите номер поезда:'
    train_num = gets.chomp.to_i
    add_train(type, train_num)
  end

  def create_route
    print 'Введите первую станцию маршрута:'
    start_station = gets.chomp
    print ' Введите конечную станцию маршрута:'
    finish_station = gets.chomp
    total_routs.push(Route.new(station_by_name(start_station), station_by_name(finish_station)))
  end

  def add_station_on_route
    print ' Выберите номер изменяемого маршрута: '
    route_index = gets.chomp.to_i
    print ' Выберите положение станции (номер стенции на маршруте): '
    station_locat = gets.chomp.to_i
    print ' Введите станцию которую хотите добавить: '
    station_name = gets.chomp
    total_routs[route_index - 1].add_station(station_locat, station_by_name(station_name)).delete(nil )
  end

  def del_station_from_route
    print ' Выберите номер изменяемого маршрута: '
    route_index = gets.chomp.to_i
    print ' Введите название удаляемой станции :'
    station_name = gets.chomp
    total_routs[route_index - 1].delete_station(station_by_name(station_name))
  end

  def sent_train_by_route
    print 'Введите номер поезда: '
    train_num = gets.chomp.to_i
    print ' Введите номер маршрута: '
    route_index = gets.chomp.to_i
    train_by_num(train_num).sent_train(total_routs[route_index - 1])
  end

  def add_carriage_to_train
    print 'Выберите поезд:'
    train_num = gets.chomp.to_i
    print 'Выберите вагон для довбавления:'
    carriage_num = gets.chomp.to_i
    train_by_num(train_num).add_carriage(carriage_by_num(carriage_num))
  end

  def del_carriage_from_train
    print 'Выберите поезд:'
    train_num = gets.chomp.to_i
    train_by_num(train_num).unhook
  end

  def sent_train_forvard
    print 'Выберите поезд:'
    train_num = gets.chomp.to_i
    train_by_num(train_num).move_forvard
  end

  def sent_train_back
    print 'Выберите поезд:'
    train_num = gets.chomp.to_i
    train_by_num(train_num).move_back
  end

  def finished_all
    puts ' Программа железная дорога завершена.'
    exit
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
      total_trains.push(PasangerTrain.new(train_num))
      puts ' Создаем поезд '
    elsif type == '2'
      total_trains.push(CargoTrain.new(train_num))
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



end

#rr=RailWay.new

