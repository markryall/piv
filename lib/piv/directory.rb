class Piv::Directory
  def initialize names
    @path = File.join(*names)
  end

  def file path, content
    full_path = File.join @path, path
    File.open full_path,'w' do |f|
      f.puts content
    end
    system "subl #{full_path}"
  end
end
