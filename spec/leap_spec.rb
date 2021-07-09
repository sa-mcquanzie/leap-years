require 'leap'

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
  end
end