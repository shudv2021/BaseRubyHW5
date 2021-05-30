class Station
  attr_reader :station_name
  attr_accessor :all_trains
  def initialize (station_name)
    @station_name = station_name
    @all_trains = []
  end

  def add_train(train)
    @all_trains<<train
  end

  def delete_train(train)
    @all_trains.delete(train)
  end

  def show_all_trains
    puts "На станции #{self.station_name} находятся:"
    @all_trains.each { |train| puts "*#{train.type}  Поезд №  #{train.train_num}*"}
  end


end

# +Может принимать поезда (по одному за раз)
# +Может возвращать список всех поездов на станции,
# +находящиеся в текущий момент
# +Может возвращать список поездов на станции по типу
# +(см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз,
# при этом, поезд удаляется из списка поездов, находящихся на станции).