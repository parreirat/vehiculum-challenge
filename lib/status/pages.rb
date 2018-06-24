# Require all our pages subclasses in the pages folder.
Dir.glob("#{Dir.pwd}/lib/status/pages/*.rb").each do |file|
	require file
end

module Status
	module Pages
	end
end