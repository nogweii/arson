class Arson
	class << self
		def colorful(color, string)
			return string unless $stdout.tty? and Arson::Config["color"]
			colored = ""
			if color.is_a? String
				Colors[color].each do |effect|
					colored << "#{::ANSICode.send(effect)}"
				end
			elsif color.is_a? Symbol
				colored << "#{::ANSICode.send(color)}"
			else
				return colorful(color.to_s, string)
			end
			colored << (string || "") << "#{::ANSICode.clear}"
		end
	end
end
