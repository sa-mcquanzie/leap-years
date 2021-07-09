require 'leap'

def random_year_divisible_by_400
  return (-2000..3000).to_a.select { |n| n % 400 == 0 }.sample
end

def random_year_divisible_by_100_and_not_400
  return (-2000..3000).to_a.select { |n| n % 100 == 0 && n % 400 != 0 }.sample
end

describe Leap do
  describe '#is_leap?' do
    it 'exists and takes one argument' do
      @leap = Leap.new
      @leap.is_leap? 0
    end

    it 'returns true when passed 2000' do
      @leap = Leap.new
      expect(@leap.is_leap?(2000)).to eq(true)
    end

    it 'returns false when passed 1700' do
      @leap = Leap.new
      expect(@leap.is_leap?(1700)).to eq(false)
    end

    it 'returns true when passed 2008' do
      @leap = Leap.new
      expect(@leap.is_leap?(2008)).to eq(true)
    end

    it 'returns false when passed 2009' do
      @leap = Leap.new
      expect(@leap.is_leap?(2009)).to eq(false)
    end

    it 'returns true when passed a random number which is divisible by 400' do
      @leap = Leap.new
      10.times do
        year = random_year_divisible_by_400
        expect(@leap.is_leap?(year)).to eq(true)
      end
    end

    it 'returns false when passed a random number which is divisible by 100 but not 400' do
      @leap = Leap.new
      10.times do
        year = random_year_divisible_by_100_and_not_400
        expect(@leap.is_leap?(year)).to eq(false)
      end
    end
  end
end