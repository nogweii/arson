require 'pp'
#$: << File.dirname(__FILE__) # Add current dir to require path
#$:.unshift File.join(File.dirname(__FILE__), "lib")
#puts $:
load 'arson' # Load arson itself for access to globals. Require doesn't work!

desc 'Release the latest version of arson'
task :release do |t|
	# Step 1: tar up the files for distribution
	#exec 'tar -xvjf '
	exec "git tag v" # #{ARSON_VERSION, etc...}
end

desc 'Update the version to the one provided as a parameter'
task :version do |t|
	version = ARSON_VERSION.join('.')
	# Tag the current revision for git
	cmd = "git tag -f -m 'Tagging arson version #{version}' v#{version}"
	puts cmd
	`#{cmd}`

	# Tar it all together for release. Remember to seperate the 2 directory structures so that the AUR files aren't released to the public
	`cp arson make_package`
	cmd = "git archive --format=tar --prefix=arson-#{version}/ v#{version}:make_package/ | gzip > arson-#{version}.tar.gz"
	puts cmd
	`#{cmd}`
end
