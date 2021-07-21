require './lib/ship'

RSpec.describe do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_a(Ship)
  end

  it 'has a name' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
  end

  it 'has a length' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.length).to eq(3)
  end

  it 'has health' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.health).to eq(3)
  end

  it 'can sink' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to eq(false)
  end

  it 'takes hits and loses health' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    expect(cruiser.health).to eq(2)
  end


  it 'sinks at 0 health' do
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    expect(cruiser.sunk?).to eq(false)
    cruiser.hit
    expect(cruiser.sunk?).to eq(false)
    cruiser.hit
    expect(cruiser.sunk?).to eq(true)
  end
end
