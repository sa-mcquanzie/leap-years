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

def divisible_by(divisor, n) = n % divisor == 0

def indivisible_by(divisor, n) = n % divisor != 0

def random_year_matching &criteria
  (list_of_leap_years.first..list_of_leap_years.last).to_a.select(&criteria).sample
end

# Tests for the Leap class

describe Leap do
  before(:each) do 
    @leap = Leap.new 
  end

  # Tests for the Leap.is_leap? method

  describe '#is_leap?' do
    context 'when an instance of the Leap class is created' do
      it 'should exist and take one argument', :fixed => true do
        @leap.is_leap? 0
      end
    end

    context 'when passed a fixed leap year' do
      it 'should return true when passed 2000', :fixed => true do
        expect( @leap.is_leap? 2000 ).to eq true
      end

      it 'should return true when passed 2008', :fixed => true do
        expect( @leap.is_leap? 2008 ).to eq true
      end
    end

    context 'when passed a fixed non-leap year' do
      it 'should return false when passed 1700', :fixed => true  do
        expect( @leap.is_leap? 1700 ).to eq false
      end

      it 'should return false when passed 2009', :fixed => true do
        expect( @leap.is_leap? 2009 ).to eq false
      end
    end

    context 'when passed a random number which qualifies as a leap year' do
      it 'should return true if it is divisible by 400', :random => true do
        10.times do
          expect( @leap.is_leap? (
            random_year_matching { |n| divisible_by(400, n) }
          )
        ).to eq true
        end
      end

      it 'should return true if it is divisible by 4 but not 100', :random => true do
        10.times do
          expect( @leap.is_leap? (
            random_year_matching { |n| divisible_by(4, n) && indivisible_by(100, n) }
          )
        ).to eq true
        end
      end
    end

    context 'when passed a random numer that qualifies as a non-leap year' do
      it 'should return false if it is divisible by 100 but not 400', :random => true  do
        10.times do
          expect( @leap.is_leap? (
            random_year_matching { |n| divisible_by(100, n) && indivisible_by(400, n) }
            )
          ).to eq false
        end
      end

      it 'should return false if it is not divisible by 4', :random => true do
        10.times do
          expect( @leap.is_leap? (
            random_year_matching { |n| indivisible_by(4, n) }
            )
          ).to eq false
        end
      end
    end

    context 'when passed a random number' do
      it 'should return true if it is in the array of leap years', :random => true do
        100.times do
          expect( @leap.is_leap? list_of_leap_years.sample ).to eq true
        end
      end

      it 'should return false if it is not in the array of leap years', :random => true do
        100.times do
          expect( @leap.is_leap? (
            random_year_matching { |n| list_of_leap_years.none? n }
            )
          ).to eq false
        end
      end
    end
  end

  # Tests for the Leap.years_between method

  describe '#years_between' do
    context 'when an instance of the Leap class is created' do
      it 'should exist and take two arguments', :fixed => true do
        @leap.years_between(1, 2)
      end
    end

    context 'when passed a fixed start and end year' do
      it 'should return an array containing all, and only, the leap years in that range', :fixed => true do
        expect( @leap.years_between(1804, 2400) ).to eq list_of_leap_years
      end
    end
  end

  # Tests for the Leap.nearest method

  describe '#nearest' do
    context 'when an instance of the Leap class is created' do
      it 'should exist and take one argument', :fixed => true do
        @leap.nearest 1
      end
    end

    context 'when passed a random number from an array of leap years' do
      it 'should tell you it is a leap year', :fixed => true do
        list_of_leap_years.each do |year|
          expect( @leap.nearest year ).to eq "#{year} is a leap year!"
        end
      end
    end

    context 'when passed a fixed non-leap year' do
      it 'should tell you the nearest leap year if there is only one', :fixed => true do
        expect( @leap.nearest 2007 ).to eq "The nearest leap year is 2008"
      end

      it 'should tell you the two nearest leap years if there are two', :fixed => true do
        expect( @leap.nearest 2006 ).to eq "The nearest leap years are 2004 and 2008"
      end
    end
  end
end