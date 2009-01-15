if ENV['RUBY_PROF']
  require 'ruby-prof'
  RubyProf.start
end

# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "integration_test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

require 'webrat/rails'
require 'cucumber/rails/rspec'
require 'webrat/rspec-rails'

Webrat.configure do |config|
  config.mode = :rails
end

module Cucumber::StepMethods
  alias_method :Gitt, :Given
  alias_method :Naar, :When
  alias_method :Saa, :Then
end

Webrat.configure do |config|
  config.mode = :rails
end 

module Hjelpefunksjoner
  def encode(streng)
    #bytter æøå med sin utf8 ekvivalent
    streng.gsub('ø', '\u00f8').gsub('Ø', '\u00d8').gsub('æ', '\u00e6').gsub('Æ', '\u00c6').gsub('å', '\u00e5').gsub('Å', '\u00c5');
  end
end

World do |world|
  world.extend(Hjelpefunksjoner)
  world
end

if ENV['RUBY_PROF']
  at_exit do
    result = RubyProf.stop

    opts = {:print_file => false}

    File.open('tmp/ruby-prof-flat.txt', 'w') do |io|
      printer = RubyProf::FlatPrinter.new(result)
      printer.print(io, opts)
    end

    File.open('tmp/ruby-prof-graph.html', 'w') do |io|
      printer = RubyProf::GraphHtmlPrinter.new(result)
      printer.print(io, opts)
    end

    File.open('tmp/ruby-prof-graph.txt', 'w') do |io|
      printer = RubyProf::GraphPrinter.new(result)
      printer.print(io, opts)
    end
  end
end
