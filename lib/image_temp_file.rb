require "tempfile"

module MiniMagick
  class ImageTempFile < Tempfile
    def make_tmpname(ext, n=0)
      'mini_magick%d-%d%s' % [$$, n, ext ? ".#{ext}" : '']
    end
  end
end
