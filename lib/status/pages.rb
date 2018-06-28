Dir.glob("#{File.dirname(__FILE__)}/pages/*") do |file|
  require file
end

module Status
	module Pages
	end
end