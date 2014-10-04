# generate js
require 'coffee-script'
require 'fileutils'

Dir.chdir("assets") do
  Dir["**/*.coffee"].each do |coffee_file|
    new_js_file = coffee_file.sub('cf', 'js')
    in_dir = File.dirname(new_js_file)
    FileUtils.mkdir_p(in_dir) unless File.exists?(in_dir)

    File.open("#{new_js_file}.js", "w+") do |js_file|
      js_file.write CoffeeScript.compile File.read coffee_file
    end
  end
end

puts "js generated"

# build jekyll site
`jekyll build`

puts "jekyll built"

# run application
require './app'
run Sinatra::Application
