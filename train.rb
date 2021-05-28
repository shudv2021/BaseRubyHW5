class Train
  attr_reader :train_num, :route, :current_station, :speed, :type, :total_carriages
  def initialize(train_num)
    @train_num = train_num
    @total_carriages = []
    @route
    @speed = 0
  end

  def add_speed(add_sp)
    @speed += add_sp
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)

    if @speed != 0
      puts 'Невозможно добавить вагон в движущийся состав.'
    return nil
    elsif carriage.type != self.type
      puts 'Невозможно добавить вагон в состав другого типа.'
    return nil
    else @total_carriages.push(carriage)
    end
  end

  def unhook
    @total_carriages.pop if @speed == 0
  end


  def sent_train(route)
    @route = route
    @current_station = route.all_stations[0]
    @current_station.all_trains.push(self)
  end

  def prev_station
    if @route.all_stations.index(@current_station) == 0
      return nil
    else
      @route.all_stations[@route.all_stations.index(@current_station) - 1]
    end
  end

  def next_station
    if @route.all_stations.index(@current_station)  == @route.all_stations.size
      return nil
    else
      #puts @route.all_stations.index(@current_station)
      #puts @route.all_stations.size
      return @route.all_stations[@route.all_stations.index(@current_station) + 1]
    end
  end

  def move(station)
    if station.nil?
      puts ' Движение на заданную станцию невозможно '
      return nil
    end
    @current_station.all_trains.delete(self)
    @current_station = station
    @current_station.all_trains.push(self)
  end

  def move_back
    move(prev_station)
  end

  def move_forvard
    move(next_station)
  end




  #+Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
  # +и количество вагонов, эти данные указываются при создании экземпляра класса
  # +Может набирать скорость
  # +Может возвращать текущую скорость
  # +Может тормозить (сбрасывать скорость до нуля)
  # +Может возвращать количество вагонов
  # +Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод
  # просто увеличивает или уменьшает количество вагонов).
  # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  # +Может принимать маршрут следования (объект класса Route).
  # +При назначении маршрута поезду, поезд автоматически помещается на первую
  # +станцию в маршруте.
  # +Может перемещаться между станциями, указанными в маршруте. Перемещение возможно
  # +вперед и назад, но только на 1 станцию за раз.
  # +Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
end