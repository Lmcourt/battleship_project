class Cell
attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil 
    @is_empty = true
    @is_fired_upon = false
  end

  def empty?
    @is_empty
  end

  def place_ship(ship)
    @ship = ship
    @is_empty = false
  end

  def fired_upon?
    @is_fired_upon
  end

  def fire_upon
    @ship.hit if @is_empty == false
    @is_fired_upon = true
  end

  def render(show_ship = false)
    if  @is_fired_upon == true && @is_empty == false && ship.sunk? == true
    "X"
    elsif @is_fired_upon == true && @is_empty == false
    "H"
    elsif @is_fired_upon == true && @is_empty == true
    "M"
  elsif show_ship == true && @is_empty == false
    "S"
    else
    "."
    end
  end
end
