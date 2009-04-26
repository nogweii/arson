class Arson
	class << self
		def colorful(color, string)
			return string unless $stdout.tty?
			colored = ""
			Colors[color].each do |effect|
			#	puts "#{effect} => ::ANSICode.send(effect) => #{::ANSICode.send(effect)}" if $VERBOSE
				colored << "#{::ANSICode.send(effect)}"
			end
			colored << (string || "") << "#{::ANSICode.clear}"
		end
	end
end
