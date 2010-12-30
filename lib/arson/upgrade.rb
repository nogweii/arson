class Arson
	class << self
		# Thanks for the cleaned up version, Gigamo! Here I go dirtying
		# it up, however. ;)
		#
		# Calls `pacman -Qm', and given each line, finds upgrades for
		# that package.
		def check_upgrades(packages = [])
			upgradable = Hash.new

			pkgs = ::IO.popen("pacman -Qm #{packages.join(' ')}", ::IO::RDONLY) {|pm| pm.read.lines}.to_a.map {|p| p.chomp}
			SimpleProgressbar.new.show("Looking for upgrades") do
				pkgs.each_with_index do |line, index|
					name, version = line.split
					result = find_exact(name)

					if result
						if ::Versionomy::parse(result['Version']) > ::Versionomy::parse(version)
							upgradable[line] = result['Version']
						end
					end
					progress ((index.to_f / pkgs.length) * 100).ceil
				end
				progress 100
			end

			upgradable#.any? ? download(upgradable) : say('Nothing to update')
		end

	end
end

# vim: sw=8 sts=8 noet
