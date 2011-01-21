# -*- ruby -*-

require 'rubygems'
require 'hoe'

# Hoe.plugin :website

Hoe.spec 'retroactive_module_inclusion' do
  developer('Adriano Mitre', 'adriano.mitre@gmail.com')
  
  self.version = '1.0.3'

  self.readme_file = 'README.rdoc'
  self.history_file = 'History.rdoc'
  self.extra_rdoc_files += ['README.rdoc', 'History.rdoc']
  self.extra_rdoc_files << ['Wishlist.rdoc'] if File.exist? 'Wishlist.rdoc'

  self.description = <<EOS
This gem circumvents the "dynamic module include" (aka "double inclusion")
problem, which is the fact that M.module_eval { include N } does not make
the methods of module N available to modules and classes which had included
module M beforehand, only to the ones that include it thereafter. This
behaviour hurts the least surprise principle, specially because if K is a
class, then K.class_eval { include M } *does* make all methods of M available
to all classes which had previously inherited it.
EOS

end

# vim: syntax=ruby

task :tests => [:test] do
  # aliasing :test with :tests for RVM ('rvm tests')
end

