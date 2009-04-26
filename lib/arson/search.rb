class Arson
	def search(*args)
	keywords = args.join(' ')
	if keywords == ""
		puts "Please specifiy what to search for as the parameters to this script"
		puts "e.g. #{PROGRAM} pacman"
		exit 1
	end
	json = open("http://aur.archlinux.org/rpc.php?type=search&arg=#{URI.escape(keywords)}").read
	hash = JSON.parse(json)
	# The most important piece of the code!
	if hash["type"] == "search"
		# Alt search orders: [pkg['CategoryID'],pkg['Name']] - ID num, then name
		#                    [Categories[pkg['CategoryID'].to_i],pkg['Name']] - Category name, then pkg name
		hash["results"].sort_by{|pkg|[pkg['Name']]}.each do |pkg|
			next if File.exists? "/var/lib/pacman/sync/community/#{pkg['Name']}-#{pkg['Version']}" # Dir["/var/lib/pacman/sync/community/#{pkg['Name']}-*"].first
			p pkg if $VERBOSE
			name = colorful("White", pkg['Name'])
			name = colorful("Red", name) if pkg["OutOfDate"] == "1"
			if Categories[pkg['CategoryID'].to_i] && Categories[pkg['CategoryID'].to_i] != "nil"
				category = "-#{Categories[pkg['CategoryID'].to_i]}"
			else
				category = ""
			end
			puts <<HERE
#{colorful("Magenta", "aur#{category}")}/#{name} #{colorful("Green",pkg['Version'])}
	#{pkg['Description']}
HERE
			$stdout.flush
		end
	end

	if File.exists? "/usr/bin/pacman-color"
		exec "/usr/bin/pacman-color -Ss #{keywords}"
	else
		exec "/usr/bin/pacman -Ss #{keywords}"
	end
end
