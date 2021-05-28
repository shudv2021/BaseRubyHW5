class CargoCarriage
  attr_reader :type, :carr_num
  def initialize(carr_num)
    @type = :cargo
    @carr_num = carr_num
  end
end