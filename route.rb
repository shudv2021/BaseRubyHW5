class Route
  attr_accessor :all_stations
  def initialize(start_staition, finish_station)
    @all_stations =[start_staition, finish_station]
  end

  def add_station (location, new_station)
    if @all_stations.include?(new_station)
      puts "Такая станция уже есть на маршруте."

    else @all_stations.insert(location, new_station)
    end
  end

  def delete_station(station_del)
    @all_stations.delete(station_del)
  end
end
