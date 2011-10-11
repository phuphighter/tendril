require 'rubygems'
require 'httparty'
require 'hashie'
require 'json'

directory = File.expand_path(File.dirname(__FILE__))

Hash.send :include, Hashie::HashExtensions

module Tendril
  
  def self.configure
    yield self
    true
  end

  class << self
    attr_accessor :email, :password, :account_id, :subdomain  
  end
  
end

require File.join(directory, 'tendril', 'client')
