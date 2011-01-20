# -*- ruby -*-

require 'rubygems'
require 'hoe'

# Hoe.plugin :rubyforge
# Hoe.plugin :website

Hoe.spec 'retroactive_module_inclusion' do
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

