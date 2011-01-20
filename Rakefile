# -*- ruby -*-

require 'rubygems'
require 'hoe'

# Hoe.plugin :compiler
# Hoe.plugin :cucumberfeatures
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :inline
# Hoe.plugin :manifest
# Hoe.plugin :newgem
# Hoe.plugin :racc
# Hoe.plugin :rubyforge
# Hoe.plugin :website

Hoe.spec 'retroactive_module_inclusion' do
  # HEY! If you fill these out in ~/.hoe_template/Rakefile.erb then
  # you'll never have to touch them again!
  # (delete this comment too, of course)

  developer('Adriano Mitre', 'adriano.mitre@gmail.com')
  
  self.version = '1.0.1'

  self.readme_file = 'README.rdoc'
  self.history_file = 'History.rdoc'
  self.extra_rdoc_files += ['README.rdoc', 'History.rdoc']
  self.extra_rdoc_files << ['Wishlist.rdoc'] if File.exist? 'Wishlist.rdoc'

  # self.rubyforge_name = 'retroactive_module_inclusionx' # if different than 'retroactive_module_inclusion'
end

# vim: syntax=ruby

task :tests => [:test] do
  # aliasing :test with :tests for RVM ('rvm tests')
end

