class Arson
	class << self
		# Given an array of search parameters, return an array of hashes
		# describing each package search result.
		def search(*args)
			keywords = args.join(' ')
			json = open("http://aur.archlinux.org/rpc.php?type=search&arg=#{URI.escape(keywords)}").read
			hash = JSON.parse(json)
			packages = []

			if hash["type"] == "search"

				# Alt search orders: [pkg['CategoryID'],pkg['Name']] - ID num, then name
				#                    [Categories[pkg['CategoryID'].to_i],pkg['Name']] - Category name, then pkg name
				hash["results"].sort_by{|pkg|[pkg['Name']]}.each do |pkg|
					# Dir["/var/lib/pacman/sync/community/#{pkg['Name']}-*"].first
					next if File.exists? "/var/lib/pacman/sync/community/#{pkg['Name']}-#{pkg['Version']}"
					p pkg if $VERBOSE
					packages << pkg
				end
			end

			packages
		end

		# Attempts to find an exact matching package in AUR
		def find_exact(arg)
			hash = JSON.parse(open("http://aur.archlinux.org/rpc.php?type=search&arg=#{URI.escape(arg)}").read)
			packages = []

			if hash["type"] == "search"

				# Alt search orders: [pkg['CategoryID'],pkg['Name']] - ID num, then name
				#                    [Categories[pkg['CategoryID'].to_i],pkg['Name']] - Category name, then pkg name
				hash["results"].sort_by{|pkg|[pkg['Name']]}.each do |pkg|
					# Dir["/var/lib/pacman/sync/community/#{pkg['Name']}-*"].first
					next if File.exists? "/var/lib/pacman/sync/community/#{pkg['Name']}-#{pkg['Version']}"
					p pkg if $VERBOSE
					return package if package['Name'] == arg
				end
			end

			return nil
		end
	end
end
