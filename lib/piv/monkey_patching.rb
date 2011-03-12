class String
  def classify
    self.split('_').map {|w| w.capitalize}.join
  end
end

class Array
  def classify
    self.map {|w| classify_one w}.join('::')
  end
end
