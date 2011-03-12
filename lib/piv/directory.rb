class Piv::Directory
  def file path, content=''
    File.open path, 'w' do |f|
      f.puts content
    end
    system "subl #{path}"
  end
end
