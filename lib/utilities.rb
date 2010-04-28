module MiniMagick
  module Utilities

    def crop_resized!(width, height, gravity="Center")
      if (width != columns || height != rows) && aspect_ratio < 300
        scale = [width/columns.to_f, height/rows.to_f].max
        resize!(scale*(columns+0.5), scale*(rows+0.5))
      end
      crop!(0, 0, width, height, gravity) if width != columns || height != rows
      self
    end

    def aspect_ratio
      ([columns,rows].max / [columns,rows].min).to_i
    end

    def crop!(x_offset, y_offset,width,height,gravity=nil)
      combine_options do |c|
        c.gravity gravity if gravity
        c.crop "#{width}x#{height}!+#{x_offset}+#{y_offset}"
      end
    end

    def resize!(width,height,filter="Lanczos")
      combine_options do |c|
        c.filter filter
        c.resize "#{width}x#{height}!"
      end
    end

    def resize_to_max!(width,height,filter="Lanczos")
      if width < columns || height < rows
        scale = [width/columns.to_f, height/rows.to_f].min
        resize!(scale*(columns-0.5), scale*(rows-0.5))
      end
    end
    
    def save_with_watermark!(watermark,save_to_file,opacity="100%")
      watermark = MiniMagick::Image.from_file(watermark)
      watermark.resize_to_max!(columns,rows)
      run_command("composite", "-dissolve", opacity, "-gravity center", watermark.path, @path, save_to_file )
    end

    def composite(symbol, *args)
      run_command("composite", "-#{symbol}", *args)
    end

    def columns
      self[:width]
    end

    def rows
      self[:height]
    end

    def depth
      self["%q"]
    end

    def filesize
      self["%b"]
    end

    def x_resolution
      self["%x"]
    end

    def y_resolution
      self["%y"]
    end

    def number_colors
      self["%k"]
    end

  end
end