module ChemRails
  class Engine < Rails::Engine

  end

  def self.getmoldetails (molfile)

    file_path = File.expand_path("../vendor/assets/bin/checkmol-0.5-linux-i586", File.dirname(__FILE__))

    command = '"' + file_path +'" -X -'
    IO.popen(command, 'r+') do |f|

      f.write (molfile)

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



