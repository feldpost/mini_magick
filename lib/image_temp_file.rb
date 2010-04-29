require "tempfile"

module MiniMagick
  class ImageTempFile < Tempfile
    def make_tmpname(ext, n)
      'mini_magick%d-%d%s' % [$$, (n || 0), ext ? ".#{ext}" : '']
    end
  end
end
