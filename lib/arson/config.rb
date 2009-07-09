require 'yaml'

class Arson
	module Config

		attr_reader :modified

		# The location of the configuration file (hard coded for now)
		FILE_PATH = File.expand_path(File.join("~", ".arson.yaml"))
		# The loaded configuration
		LOADED_YAML = File.exists?(FILE_PATH) ? open(FILE_PATH) {|f| YAML::load(f) } : nil
		# Default configuration values
		DEFAULTS = {"target_directory" => File.expand_path("~"), "run_pacman" => true, "color" => true, "show_category" => true, "directory_alias" => nil}
		# Merged values representing a combination of the user's choices
		# and the defaults
		MERGED = LOADED_YAML ? DEFAULTS.merge(LOADED_YAML) : DEFAULTS

		# Returns the value for that configuration option (as a string)
		def self.[](option)
			value = MERGED[option.to_s]
			
			# Hash#merge() overwrites the value, even if it's an
			# empty string or nil. Therefore, check if the user has a
			# nil value in their configuration and update the hash.
			if value.nil? or value.empty?
				MERGED[option.to_s] = DEFAULTS[option.to_s]
				@modified = true
			end

			return value
		end

		# Write the merged YAML (the user's choices and the defaults) to
		# the file.
		def self.write
			open(FILE_PATH, "w") do |file|
				file.write(MERGED.to_yaml)
			end
		end

		# The correct directory to *output*, taking into account
		# target_directory and directory_alias.
		#
		# Note: Always use target_directory as the path to put files in,
		# or in the appropriate XDG directory.
		def self.directory_name
			return (self["directory_alias"] or self["target_directory"])
		end
	end
end
