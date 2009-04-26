class Arson
	# +package+ is expected to be a Hash, matching the structure the AUR
	# RPC returns.
	def download(package, depends=false)
	end

	private

	# The real downloading code, the parameter is expected to be a valid
	# URL. No error checking is done.
	#
	# After the file is downloaded, it is attempted to be unpacked using
	# tar and gunzip formats.
	def real_download(url)
	end
end
