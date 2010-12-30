class Arson
	class << self
		def colorful(color, string)
			return string unless $stdout.tty? and Arson::Config["color"]
			colored = ""
			if color.is_a? String
				Colors[color].each do |effect|
					colored << "#{::ANSI::Code.send(effect)}"
				end
			elsif color.is_a? Symbol
				colored << "#{::ANSI::Code.send(color)}"
			else
				return colorful(color.to_s, string)
			end
			colored << (string || "") << "#{::ANSI::Code.clear}"
		end
	end
end

# vim: sw=8 sts=8 noet
