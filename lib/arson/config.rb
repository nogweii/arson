require 'yaml'

class Arson
	module Config

		# The location of the configuration file (hard coded for now)
		FILE_PATH = File.expand_path(File.join("~", ".arson.yaml"))
		# The loaded configuration
		LOADED_YAML = File.exists?(FILE_PATH) ? open(FILE_PATH) {|f| YAML::load(f) } : {}
		# Default configuration values
		DEFAULTS = {"dir" => File.expand_path("~"), "run-pacman" => true, "color" => true}
		# Merged values representing a combination of the user's choices
		# and the defaults
		MERGED = LOADED_YAML ? DEFAULTS.merge(LOADED_YAML) : DEFAULTS

		# Returns the value for that configuration option (as a string)
		def self.[](option)
			MERGED[option.to_s]
		end

		def self.write
			open(FILE_PATH, "w") do |file|
				file.write(DEFAULTS.to_yaml)
			end
		end
	end
end
