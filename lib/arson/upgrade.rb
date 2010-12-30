class Arson
	class << self
		# Thanks for the cleaned up version, Gigamo! Here I go dirtying
		# it up, however. ;)
		#
		# Calls `pacman -Qm', and given each line, finds upgrades for
		# that package.
		def check_upgrades
			upgradable = Hash.new

			::IO.popen('pacman -Qm', ::IO::RDONLY) {|pm| pm.read.lines}.each do |line|
				name, version = line.chomp.split
				result = find_exact(name)

				if result
					if ::Versiononmy::parse(result['Version']) > ::Versionomy::parse(version)
						upgradable[line] = result['Version']
					end
				end
			end

			upgradable#.any? ? download(upgradable) : say('Nothing to update')
		end

	end
end

# vim: sw=8 sts=8 noet
