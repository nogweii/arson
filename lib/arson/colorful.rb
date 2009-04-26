class Arson
	def colorful(color, string)
		return string unless $stdout.tty?
		colored = ""
		Colors[color].each do |effect|
			colored << "#{ANSICode.send(effect)}"
		end
		colored << string << "#{ANSICode.clear}"
	end	
end
