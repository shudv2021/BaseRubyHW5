require_relative 'route.rb'
require_relative 'stations.rb'
require_relative 'pasangertrain.rb'
require_relative 'cargo_carriage.rb'
require_relative 'passanger_carriage.rb'
require_relative 'cargotrain.rb'
require_relative 'rail_way.rb'

rr=RailWay.new
rr.seed

loop  do
  puts '  '
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
  rr.total_stations.push(Station.new(station_name))
when '2'
  rr.total_stations.each { |station| puts station.station_name}
when '3'
  puts ' Введите название станции'
  station_name = gets.chomp
  rr.total_stations.each do |station|
    if station.station_name == station_name
      puts " На станции #{station_name} находятся поезда. "
      station.all_trains.each { |train| puts "№ #{train.train_num} -- #{train.type} -- #{train.total_carriages.size}"}
    end
  end
when '4'
  print ' Выберите тип новго поезда 1.Пассажирски/2.Грузовой: '
  type = gets.chomp
  print 'Введите номер поезда:'
  train_num = gets.chomp.to_i
  if type == '1'
    rr.total_trains.push(PasangerTrain.new(train_num))
    puts 'Создаем поезд'
    puts rr.total_trains.inspect
  elsif type == '2'
    rr.total_trains.push(CargoTrain.new(train_num))
    else puts ' Невозможно создать такой поезд '
  end
when '5'
  print 'Введите первую станцию маршрута'
  start_station = gets.chomp
  print ' Введите конечную станцию маршрута'
  finish_station = gets.chomp
  rr.total_routs.push(Route.new(rr.station_by_name(start_station), rr.station_by_name(finish_station)))

when '6'
  print ' Выберите номер изменяемого маршрута: '
  route_index = gets.chomp.to_i
  print ' Выберите положение станции (номер стенции на маршруте): '
  station_lacat = gets.chomp.to_i
  print ' Введите станцию которую хотите добавить: '
  station_name = gets.chomp
  rr.total_routs[route_index - 1].add_station(station_lacat, rr.station_by_name(station_name))

when '7'
  print ' Выберите номер изменяемого маршрута: '
  route_index = gets.chomp.to_i
  print ' Введите название удаляемой станции :'
  station_name = gets.chomp
  rr.total_routs[route_index - 1].delete_station(rr.station_by_name(station_name))

when '8'
  rr.total_routs.each_with_index do |route, index|
    print " Маршрут #{index + 1}: "
    route.all_stations.each do |station|
      print " *#{station.station_name}* "
    end
    puts " \n_____________________________________ "
  end

when '9'
  print 'Введите номер поезда: '
  train_num = gets.chomp.to_i
  print ' Введите номер маршрута: '
  route_index = gets.chomp.to_i
  rr.train_by_num(train_num).sent_train(rr.total_routs[route_index - 1])
when '10'
  print 'Выберите поезд:'
  train_num = gets.chomp.to_i
  print 'Выберите вагон для довавления:'
  carriage_num = gets.chomp.to_i
  rr.train_by_num(train_num).add_carriage(rr.carriage_by_num(carriage_num))
  when '11'
  when '12'
when '13'
when '14'
  puts ' Программа железная дорога завершена.'
  exit
  end
system 'clear'
#Не работает. Не могу понять почему
end




#(Задание:
#
#     Разбить программу на отдельные классы (каждый класс в отдельном файле)
#     Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие методы и свойства
#     Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. В комментарии к методу обосновать, почему он был вынесен в private/protected
#     Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые.
#     При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода и сохраняться во внутреннем массиве поезда, в отличие от предыдущего задания, где мы считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.
#
#
# Добавить текстовый интерфейс:
#
# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
#      - Создавать станции
#      - Создавать поезда
#      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#      - Назначать маршрут поезду
#      - Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад
#      - Просматривать список станций и список поездов на станции)