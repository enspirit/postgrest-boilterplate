require 'webspicy'

Webspicy::Configuration.new(Path.dir) do |c|
  c.host = "http://api:3000"
end
