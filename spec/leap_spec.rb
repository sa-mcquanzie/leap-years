require 'leap'

describe Leap do
  describe '#is_leap?' do
    it 'exists and takes one argument' do
      @leap = Leap.new
      @leap.is_leap? 0
    end
  end
end