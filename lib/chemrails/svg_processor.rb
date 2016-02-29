require 'nokogiri'

module ChemRails
  class SVGProcessor
    attr_accessor :margin
    attr_reader :min,:max,:svg

    def initialize(svg="")
      @svg = Nokogiri::HTML(svg)
      @min,@max=[nil,nil],[nil,nil]
      @margin=[10,10]
      paths
    end

    def paths
      @paths = @svg.xpath("//path")
    end

    def circles
      @circles = @svg.at_css("circle")
    end

    def splitxy_for_path_at(ind)
      d(paths[ind])
    end


    def path_extrema(ind=nil)
      if ind
        splitxy_for_path_at(ind)
        minmax
        return [@min,@max]
      end
      paths.each do |path|
        coordinates = splitxy_for_path(path["d"])
        minmax(coordinates)
      end
    end

    def circle_extrema
      circles.each do |circle|
        if !circle["style"].match(/display:\s*none/)
          coordinates = splitxy_for_circle(circle)
          minmax(coordinates)
        end
      end
    end

    def viewbox
      @viewbox = @svg.xpath("//svg")[0]["viewbox"]#.split(/,| /)
    end

    def recenter
      return if ([@min,@max].flatten.compact.empty?)
       minx,miny = *@min
       maxx,maxy = *@max
       marx,mary = *@margin
       x,y,width,height = minx,miny,maxx-minx+marx,maxy-miny+mary
       if minx < marx
         #todo apply transformation: translate everything by marx-minx
         x = 0
       else
         x = minx - marx
         width += marx
       end
       if miny < mary
         #todo apply transformation: translate everything by marx-minx
         y = 0
       else
         y = miny - mary
         height += mary
       end

       vb="%i %i %i %i" %[x,y,width,height]
       @svg.at_css("svg")["viewbox"]=vb
    end

    private

    def d(node)
      d=node["d"]
      @d=splitxy(d)
    end

    def minmax(d=@d)
      d&&d.each do |xy|
        mini(xy)
        maxi(xy)
      end
    end

    def mini(new_value)
      x,y = *new_value
      x0,y0 = *@min
      @min=[ x <= (x0||x) && x || x0, y <= (y0||y) && y || y0]
    end

    def maxi(new_value)
      x,y = *new_value
      x0,y0 = *@max
      p [x,y,x0,y0]
      @max=[ x >= (x0||x) && x || x0, y >= (y0||y) && y || y0]
    end


    def splitxy_for_circle(circle)
      cx,cy,r=circle["cx"].to_f,circle["cy"].to_f,circle["r"].to_f
      [[cx-r,cy-r],[cx+r,cy+r]]
    end

    def splitxy_for_path(d="",origin=[0,0])
      splitted=[]
      d.match(/\s*([mlhvzMLHVZ])/) && (command,data=$1,$')
      while data!=""
        case command
        when "M"
          data.match(/([-+]?\d+\.?\d*)\s*,\s*([-+]?\d+\.?\d*)\s*/) && (origin,data = [$1.to_f,$2.to_f],$') && splitted<<origin
        when "m"
          data.match(/[-+]?(\d+\.?\d*)\s*,\s*([-+]?\d+\.?\d*)\s*/) && (origin,data = [origin[0]+$1.to_f,origin[1]+$2.to_f],$') && splitted<<origin
        when "L"
          data.match(/[-+]?(\d+\.?\d*)\s*,\s*([-+]?\d+\.?\d*)\s*/) &&  (origin,data = [$1.to_f,$2.to_f],$') && splitted<<origin
        when "l"
          data.match(/[-+]?(\d+\.?\d*)\s*,\s*([-+]?\d+\.?\d*)\s*/) && (origin,data = [origin[0]+$1.to_f,origin[1]+$2.to_f],$') && splitted<<origin
        when "H"
          data.match(/[-+]?(\d+\.?\d*)\s*,?\s*/) && (origin,data = [$1.to_f,origin[1]],$') && splitted<<origin
          data.match(/[-+]?(\d+\.?\d*)\s*,?\s*/) && (origin,data = [$1.to_f+origin[0],origin[1]],$') && splitted<<origin
        when "V"
          data.match(/[-+]?(\d+\.?\d*)\s*,?\s*/) && (origin,data = [origin[0],$1.to_f],$') && splitted<<origin
        when "v"
        when "h"
          data.match(/[-+]?(\d+\.?\d*)\s*,?\s*/) && (origin,data = [origin[0],$1.to_f+origin[1]],$') && splitted<<origin
        when "Z"
        when "z"

        #todo cubic bezier https://www.w3.org/TR/SVG/paths.html#PathData
        when "s"
        when "S"
        when "c"
        when "C"
        end
        data.match(/\s*([mlhvzscMLHVZSC])/) && (command,data=$1,$') || (data="")
      end
      splitted
    end

  end #class SVGProcessor
end #module ChemRails
