# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "integration_test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

require 'webrat/rails'
require 'cucumber/rails/rspec'
require 'webrat/rspec-rails'

# Nokogiri har tilsynelatende UTF-8 problemer
require 'hpricot'
Webrat.configuration.parse_with_nokogiri = false

module Cucumber::StepMethods
  alias_method :Gitt, :Given
  alias_method :Naar, :When
  alias_method :Saa, :Then
end