module Piv
end

class Piv::Preferences
  def initialize
    @preference_path = home_path '.pivrc'
    @preferences = {}
    @preferences = YAML.load_file(@preference_path) if File.exists?(@preference_path)
  end

  def home_path *paths
    File.join File.expand_path('~'), *paths
  end
  
  def [] key
    unless @preferences[key]
      print "Enter #{key} > "
      self[key] = $stdin.gets.chomp
    end
    @preferences[key]
  end

  def []= key, value
    @preferences[key] = value
    persist
  end

  def persist
    File.open(@preference_path, 'w') {|f| f.puts @preferences.to_yaml}
  end
end
