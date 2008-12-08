# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

require 'cucumber/rails/rspec'

module Cucumber::StepMethods
  alias_method :Gitt, :Given
  alias_method :Naar, :When
  alias_method :Saa, :Then
end