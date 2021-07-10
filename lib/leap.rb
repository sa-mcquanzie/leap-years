class Leap
  def is_leap? year
    year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) ? true : false
  end

  def years_between(first, last)
    (first..last).to_a.select { |year| is_leap? year }
  end
end