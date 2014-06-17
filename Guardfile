# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#
guard :shell do
  watch(%r{^site-cookbooks/(.+)\.rb$}) {|m| `ruby -c #{m[0]} ; bundle exec foodcritic site-cookbooks/lw1_virtuoso` }
end
