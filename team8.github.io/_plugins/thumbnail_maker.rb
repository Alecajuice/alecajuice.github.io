require 'mini_magick'

module ThumbnailMaker
  include Liquid::StandardFilters

  def thumbnail(path, dimensions = "100x100<")
    @source = path
    @dimensions = dimensions

    if @source
      # parking
      source = @source
      dimensions = @dimensions

      source_path = "#{source}"
      raise "#{source} is not readable" unless File.readable?(source_path)
      ext = File.extname(source)
      desc = dimensions.gsub(/[^\da-z]+/i, '')
      dest = "#{File.dirname(source)}/#{File.basename(source, ext)}_#{desc}#{ext}"
      dest_path = "#{dest}"

      # only thumbnail the image if it doesn't exist tor is less recent than the source file
      # will prevent re-processing thumbnails for a ton of images...
      if !File.exists?(dest_path) || File.mtime(dest_path) <= File.mtime(source_path)
        # puts ENV.inspect

        # don't generate images in preview mode whenever possible
        if ENV['OCTOPRESS_ENV'] == 'preview' && /(?<width>\d+)?x(?<height>\d+)?/ =~ dimensions
          html = "<img src='#{source}' style='"
          html << "max-width: #{width}px; " unless width.nil? || width.empty?
          html << "max-height: #{height}px;" unless height.nil? || height.empty?
          html << "' />"
          return html
        end

        puts "Thumbnailing #{source} to #{dest} (#{dimensions})"

        image = MiniMagick::Image.open(source_path)
        image.strip
        image.resize dimensions
        image.write dest_path
      end
      return "/#{dest}"
    else
      "Could not create thumbnail for #{source}. Usage: thumbnail /path/to/local/image.png 50x50<"
    end
  end
end

Liquid::Template.register_filter ThumbnailMaker
