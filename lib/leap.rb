class Leap
  def is_leap? year
    year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) ? true : false
  end

  def years_between(first, last)
    (first..last).to_a.select { |year| is_leap? year }
  end

  def nearest year
    return "#{year} is a leap year!" if is_leap? year

    message = "The nearest leap year"
    hi, lo = year, year

    loop do
      hi, lo = hi += 1, lo -= 1
      return message + "s are #{lo} and #{hi}" if is_leap?(hi) && is_leap?(lo)
      return message + " is #{hi}" if is_leap? hi
      return message + " is #{lo}" if is_leap? lo
    end
  end
end