require 'yaml'

class Arson
	module Config

		# The location of the configuration file (hard coded for now)
		FILE_PATH = File.expand_path(File.join("~", ".arson.yaml"))
		# The loaded configuration
		LOADED_YAML = File.exists?(FILE_PATH) ? open(FILE_PATH) {|f| YAML::load(f) } : nil
		# Default configuration values
		DEFAULTS = {"target_directory" => File.expand_path("~"), "run_pacman" => true, "color" => true, "download_on_single_result" => false, "show_category" => true, "directory_alias" => nil}
		# Merged values representing a combination of the user's choices
		# and the defaults
		MERGED = LOADED_YAML ? DEFAULTS.merge(LOADED_YAML) : DEFAULTS

		# Returns the value for that configuration option (as a string)
		def self.[](option)
			MERGED[option.to_s]
		end

		# Write the merged YAML (the user's choices and the defaults) to
		# the file.
		def self.write
			open(FILE_PATH, "w") do |file|
				file.write(MERGED.to_yaml)
			end
		end

	end
end
