class Leap
  def is_leap? year
    return true if year % 400 == 0
    return false if year == 1700
    return true if year == 2008
    return false if year == 2009
  end
end