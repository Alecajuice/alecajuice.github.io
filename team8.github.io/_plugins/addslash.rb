module AddSlash
  include Liquid::StandardFilters

  def addslash(path)
    "/#{path}"
  end
end

Liquid::Template.register_filter AddSlash
