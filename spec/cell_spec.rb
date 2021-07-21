require './lib/ship'
require './lib/cell'
require 'pry'
RSpec.describe do
  it 'exists' do
    cell = Cell.new("B4")

    expect(cell).to be_a(Cell)
  end

  it 'has coordinates' do
    cell = Cell.new("B4")

    expect(cell.coordinate).to eq("B4")
  end

  it 'is empty' do
    cell = Cell.new("B4")

    expect(cell.ship).to eq(nil)
    expect(cell.empty?).to eq(true)
  end

  it 'has a ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it 'is fired upon empty cell' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.fired_upon?).to eq(false)
  end

  it 'is reducing ships health by one' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    cell.fire_upon
    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to eq(true)
  end

  it 'is a miss' do
    cell_1 = Cell.new("B4")

    expect(cell_1.render).to eq(".")
    cell_1.fire_upon
    expect(cell_1.render).to eq("M")
  end

  it 'the ship is revealed' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    expect(cell_2.render).to eq(".")
    expect(cell_2.render(true)).to eq("S")
  end

  it 'is hit' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    cell_2.fire_upon
    expect(cell_2.render).to eq("H")
    expect(cruiser.sunk?).to eq(false)
  end

  it "has sunk" do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    cruiser.hit
    cruiser.hit
    cell_2.fire_upon
    expect(cruiser.sunk?).to eq(true)
    expect(cell_2.render).to eq("X")
  end

end
