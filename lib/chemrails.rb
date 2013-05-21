module ChemRails
  class Engine < Rails::Engine

  end

  def self.getmoldetails

    command = '"./app/bin/checkmol-0.5-linux-i586" -x -'
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

         
      return File.read(File.expand_path('app/assets/bin/thing.mol'))

  end

end



