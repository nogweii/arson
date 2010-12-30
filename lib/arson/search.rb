require 'find'

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
					packages << pkg
				end
			end

			packages
		end

		# Attempts to find an exact matching package in AUR
		def find_exact(arg)
			hash = JSON.parse(open("http://aur.archlinux.org/rpc.php?type=search&arg=#{URI.escape(arg)}").read)

			if hash["type"] == "search"

				# Alt search orders: [pkg['CategoryID'],pkg['Name']] - ID num, then name
				#                    [Categories[pkg['CategoryID'].to_i],pkg['Name']] - Category name, then pkg name
				hash["results"].sort_by{|pkg|[pkg['Name']]}.each do |pkg|
					# Dir["/var/lib/pacman/sync/community/#{pkg['Name']}-*"].first
					if available_via_pacman?(pkg['Name'], pkg['Version'])
						$Log.debug "Skipping in-sync package #{pkg['Name']}"
					elsif pkg['Name'] == arg
						$Log.debug "Exact match found: #{pkg}"
						return pkg
					else
						$Log.debug "Skipping partial match: #{pkg['Name']}"
					end
				end
			end

			return nil
		end

		# Search for a package in pacman's local cache. If found, we
		# presume that the package is one stored in a repository, not
		# in the AUR.
		#
		# @returns [boolean] true or false
		def available_via_pacman?(pkg, version=nil)
			found = Dir["/var/lib/pacman/sync/#{pkg}*"].find_all do |d|
				versionmatcher = if version.nil?
							 '[\d\.-]+'
						 else
							 Regexp.escape(version)
					d =~ /^#{Regexp.escape(pkg)}-#{versionmatcher}$/
						 end
			end
			return !found.empty?
		end
	end
end

# vim: sw=8 sts=8 noet
