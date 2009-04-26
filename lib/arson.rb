require 'open-uri'
require 'rubygems'
require 'json'
require 'facets/ansicode'

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
		line=~ /^#/||line=~ /^$/
	end.map do |line|
		a=line.split("=").map(&:strip); [a[0], a[1].sub(/intensive/, "bold").split.map(&:to_sym)]
	end ] ) if File.exists? "/etc/pacman.d/color.conf"

	VERSION = "0.9.1"
	PROGRAM = File.basename(__FILE__)
end
