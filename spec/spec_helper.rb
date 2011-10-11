require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'vcr_setup'
require 'tendril'
require 'active_support'

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end