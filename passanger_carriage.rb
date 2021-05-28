class PassangerCarriage
  attr_reader :type, :carr_num
  def initialize(carr_num)
    @type = :passanger
    @carr_num = carr_num
  end
end