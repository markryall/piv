class String
  def classify
    self.split('_').map(&:capitalize).join
  end
end

class Array
  def classify
    self.map(&:classify).join('::')
  end
end