require_relative 'route.rb'
require_relative 'stations.rb'
#Подключем поезда
require_relative 'train.rb'
require_relative 'pasangertrain.rb'
require_relative 'cargotrain.rb'
#подключаем вагоны
require_relative 'cargo_carriage.rb'
require_relative 'passanger_carriage.rb'
@total_stations = []

@total_stations.push(Station.new('Krasnodar'))
@total_stations << Station.new('Rostov')
@total_stations << Station.new('Voronezh')
@total_stations << Station.new('Moskva')
@total_stations << Station.new('Vladimir')
#@total_stations.each { |station| puts station.station_name}
puts '***********************************************************'
#создание маршрута
route1 = Route.new(@total_stations[0], @total_stations[4])
route1.add_staition(1,@total_stations[1])
route1.add_staition(2,@total_stations[2])
route1.add_staition(3,@total_stations[3])
route1.all_stations.each { |station| puts station.station_name}
#создание 2х обьектов каждого подвижного класса
caca1 = CargoCarriage.new('cc111')
caca2 = CargoCarriage.new('cc222')
psca1 = PassangerCarriage.new('pc333')
psca2 = PassangerCarriage.new('pc444')
catr1 = CargoTrain.new('ct001')
pstr2 = PasangerTrain.new('ps002')

#catr1.add_speed(20)
catr1.add_carrige(caca1)
catr1.add_carrige(caca2)
puts catr1.total_carriages.size
puts caca1.inspect
puts pstr2.inspect
pstr2.add_carrige(psca1)


