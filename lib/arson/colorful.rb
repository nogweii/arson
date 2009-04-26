class Arson
	class << self
		def colorful(color, string)
			return string unless $stdout.tty?
			colored = ""
			if color.is_a? String
				Colors[color].each do |effect|
					colored << "#{::ANSICode.send(effect)}"
				end
			elsif color.is_a? Symbol
				colored << "#{::ANSICode.send(effect)}"
			else
				return colorful(color.to_s, string)
			end
			colored << (string || "") << "#{::ANSICode.clear}"
		end
	end
end
