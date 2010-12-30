class Arson
	class << self
		# +package+ is expected to be a Hash, matching the structure the AUR
		# RPC returns.
		# TODO: Add automatic dependency tracking (gleaned parsing the PKGBUILD)
		def download(package, get_dependencies=false)
			puts "Downloading #{packages.first['Name']} to #{Arson::Config.directory_name}..."
			begin
				real_download("http://aur.archlinux.org"+package['URLPath'])
				if get_dependencies
					dependencies = File.readlines("#{Arson::Config["target_directory"]}/#{package['Name']}/PKGBUILD").grep(/^(?:make)*depends/).map{|l| l.match(/.*=\((.*)\)$/)[1].gsub("'", '').split(' ')}.flatten.uniq.sort.map{|dep| (dep.scan(/(.*?)[><=]{1,2}(.*)/).first || [dep]).first }
					# Remove all those packages that are found in pacman's
					# package database
					dependencies.reject { |depend| !is_sync?(depend) }
					puts "Download #{dependencies.size} dependencies... #{dependencies.inspect}"
				end
			rescue Errno::EEXIST => e
				warn "arson: #{e.message}"
				exit 2
			rescue SocketError => e
				warn "arson: #{e.message}"
				exit 2
			end
		end

		private

		# The real downloading code, the parameter is expected to be a valid
		# URL. No error checking is done.
		#
		# After the file is downloaded, it is attempted to be unpacked using
		# tar and gunzip formats.
		def real_download(url)
			Dir.chdir(Arson::Config["target_directory"]) do
				open(url) do |tar|
					# Write the stream to a file, b (binary) is JIC
					File.open(File.basename(url), "wb") do |file|
						file.write(tar.read)
					end
				end
				tgz = Zlib::GzipReader.new(File.open(File.basename(url), 'rb'))
				# Extract pkg.tar.gz to `pwd`, instead of `pwd`/pkg
				Archive::Tar::Minitar.unpack(tgz, Dir.pwd)
				FileUtils.mv File.basename(url), File.join(Dir.pwd, File.basename(url)[0..-8])
			end
		end
	end
end

# vim: sw=8 sts=8 noet
