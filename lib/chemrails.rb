module ChemRails
  class Engine < Rails::Engine

  end

  def self.getmoldetails

    file_path = File.expand_path("../vendor/assets/bin/checkmol-0.5-linux-i586", File.dirname(__FILE__))

    return file_path

    command = '"' + file_path +'" -x -'
    IO.popen(command, 'r+') do |f|

      f.write ('Compound\r\n
        Creator\r\n
        \r\n
  2  1  0  0  0  0            999 v2000\r\n
   -0.4330   -0.2500    0.0000 H   0  0  0  0  0  0\r\n
    0.4330    0.2500    0.0000 C   0  0  0  0  0  0\r\n
  1  2  1  0     0  0\r\n
M  END')

      f.close_write
      output = f.readlines
      f.close

      return output
    end

  end

  def self.getmolfile

      file_path = File.expand_path("../vendor/assets/bin/thing.mol", File.dirname(__FILE__))
      return IO.read (file_path)

  end

end



