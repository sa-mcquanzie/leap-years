require 'leap'

# Test helpers

def list_of_leap_years
  %w(
    1804 1808 1812 1816 1820 1824 1828 1832 1836 1840 1844 1848 1852 1856 1860
    1864 1868 1872 1876 1880 1884 1888 1892 1896 1904 1908 1912 1916 1920 1924
    1928 1932 1936 1940 1944 1948 1952 1956 1960 1964 1968 1972 1976 1980 1984
    1988 1992 1996 2000 2004 2008 2012 2016 2020 2024 2028 2032 2036 2040 2044
    2048 2052 2056 2060 2064 2068 2072 2076 2080 2084 2088 2092 2096 2104 2108
    2112 2116 2120 2124 2128 2132 2136 2140 2144 2148 2152 2156 2160 2164 2168
    2172 2176 2180 2184 2188 2192 2196 2204 2208 2212 2216 2220 2224 2228 2232
    2236 2240 2244 2248 2252 2256 2260 2264 2268 2272 2276 2280 2284 2288 2292
    2296 2304 2308 2312 2316 2320 2324 2328 2332 2336 2340 2344 2348 2352 2356
    2360 2364 2368 2372 2376 2380 2384 2388 2392 2396 2400
  ).map(&:to_i)
end

def random_year_divisible_by_400
  (-2000..3000).to_a.select { |n| n % 400 == 0 }.sample
end

def random_year_divisible_by_100_and_not_400
  (-2000..3000).to_a.select { |n| n % 100 == 0 && n % 400 != 0 }.sample
end

def random_year_divisible_by_4_and_not_100
  (-2000..3000).to_a.select { |n| n % 4 == 0 && n % 100 != 0 }.sample
end

def random_year_not_divisible_by_4
  (-2000..3000).to_a.select { |n| n % 4 != 0 }.sample
end

def random_leap_year
  list_of_leap_years.sample
end

def random_non_leap_year
  (1804..2400).to_a.select { |n| list_of_leap_years.none? n }.sample
end

# Tests for the Leap class

describe Leap do

  # Tests for the Leap.is_leap? method

  describe '#is_leap?' do
    it 'exists and takes one argument' do
      @leap = Leap.new
      @leap.is_leap? 0
    end

    it 'returns true when passed 2000' do
      @leap = Leap.new
      expect( @leap.is_leap? 2000 ).to eq true
    end

    it 'returns false when passed 1700' do
      @leap = Leap.new
      expect( @leap.is_leap? 1700 ).to eq false
    end

    it 'returns true when passed 2008' do
      @leap = Leap.new
      expect( @leap.is_leap? 2008 ).to eq true
    end

    it 'returns false when passed 2009' do
      @leap = Leap.new
      expect( @leap.is_leap? 2009 ).to eq false
    end

    it 'returns true when passed a random number which is divisible by 400' do
      @leap = Leap.new
      10.times do
        expect( @leap.is_leap? random_year_divisible_by_400 ).to eq true
      end
    end

    it 'returns false when passed a random number which is divisible by 100 but not 400' do
      @leap = Leap.new
      10.times do
        expect( @leap.is_leap? random_year_divisible_by_100_and_not_400 ).to eq false
      end
    end

    it 'returns true when passed a random number which is divisible by 4 but not 100' do
      @leap = Leap.new
      10.times do
        expect( @leap.is_leap? random_year_divisible_by_4_and_not_100 ).to eq true
      end
    end

    it 'returns false when passed a random number which is not divisible by 4' do
      @leap = Leap.new
      10.times do
        expect( @leap.is_leap? random_year_not_divisible_by_4 ).to eq false
      end
    end

    it 'returns true when passed a random sample from a large array of known leap years' do
      @leap = Leap.new
      100.times do
        expect( @leap.is_leap? random_leap_year ).to eq true
      end
    end

    it 'returns false when passed a random selection of known non-leap years' do
      @leap = Leap.new
      100.times do
        expect( @leap.is_leap? random_non_leap_year ).to eq false
      end
    end
  end

  # Tests for the Leap.years_between method

  describe '#years_between' do
    it 'exists and takes two arguments' do
      @leap = Leap.new
      @leap.years_between(1, 2)
    end

    it 'returns an array containing all, and only, the leap years in the range 1804 to 2400, inclusive' do
      @leap = Leap.new
      expect( @leap.years_between(1804, 2400) ).to eq list_of_leap_years
    end
  end

  # Tests for the Leap.nearest method

  describe '#nearest' do
    it 'exists and takes one argument' do
      @leap = Leap.new
      @leap.nearest 1
    end

    it 'returns "<year> is a leap year!" when passed a leap year' do
      @leap = Leap.new
      list_of_leap_years.each do |year|
        expect( @leap.nearest year ).to eq "#{year} is a leap year!"
      end
    end

    it 'returns "The nearest leap year is 2008" when passed 2007' do
      @leap = Leap.new
      expect( @leap.nearest 2007 ).to eq "The nearest leap year is 2008"
    end

    it 'returns "The nearest leap years are 2004 and 2008" when passed 2006' do
      @leap = Leap.new
      expect( @leap.nearest 2006 ).to eq "The nearest leap years are 2004 and 2008"
    end
  end
end