module ChemRails
  class Engine < Rails::Engine

  end

  def self.getmoldetails (molfile)

    file_path = File.expand_path("../vendor/assets/bin/checkmol-0.5-linux-i586", File.dirname(__FILE__))

    command = '"' + file_path +'" -x -'
    output = ""

    IO.popen(command, 'r+') do |f|

      f.write (molfile)

      f.close_write
      output = f.readlines[0]
      f.close

    end


    the_hash = Hash.new

    output.split(";").each do |x|
      k,v = x.split(":")
      the_hash[k.to_sym] = v
    end

    return the_hash

  end

end



