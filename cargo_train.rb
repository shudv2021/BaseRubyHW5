require_relative 'train.rb'
class CargoTrain < Train
  def initialize(train_num)
    super
    @type = :cargo
  end
end