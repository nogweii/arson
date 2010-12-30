require 'open-uri'
require 'zlib'
require 'rubygems'
require 'json'
require 'ansi'
require 'archive/tar/minitar'
require 'versionomy'
require 'simple_progressbar'

require 'arson/version'
require 'arson/config'
require 'arson/search'
require 'arson/download'
require 'arson/upgrade'

class Arson
	# I wish the AUR had an RPC for these, or replaced CategoryID with the name
	# instead. The first 'nil' is padding, since the categories start at index
	# 1, going through 18, instead of being sensible and starting from 0.
	Categories = %w{nil nil daemons devel editors emulators games gnome
			i18n kde lib modules multimedia network office
			science system x11 xfce kernels}

	# Defaults from pacman-color
	Colors = {"Magenta" => [:bold, :magenta],
		  "White" => [:bold],
		  "Cyan" => [:bold, :cyan],
		  "Blue" => [:bold, :blue],
		  "Yellow" => [:bold, :yellow],
		  "Red" => [:bold, :red],
		  "Green" => [:bold, :green]}
	# And support for user modifications. Note that inline comments (ie 
	# "White = gray # blah blah") aren't supported and cause this to crash
	Colors.merge!( Hash[ open("/etc/pacman.d/color.conf").readlines.map(&:strip).reject do |line|
		line=~ /^#/ || line=~ /^$/
	end.map do |line|
		array = line.split("=").map(&:strip)
		[a[0], a[1].sub(/intensive/, "bold").split.map(&:to_sym)]
	end ] ) if File.exists? "/etc/pacman.d/color.conf"

	PROGRAM = File.basename($0)

	REPOSITORIES = File.read("/etc/pacman.conf").scan(/\[(.*)\]/).flatten
	REPOSITORIES.shift # Remove '[options]'
end
