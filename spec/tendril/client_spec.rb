require 'spec_helper'
require 'active_support/core_ext'

describe Tendril::Client do
  
  context 'pricing' do
    use_vcr_cassette 'pricing'

    it 'should initialize' do
      @client = Tendril::Client.new(:email => "jason@tendrilinc.com", :password => "password", :subdomain => "dev-program")
      @client.email.should == "jason@tendrilinc.com"
      @client.password.should == "password"
      @client.subdomain.should == "dev-program"
    end

    it 'should request pricing schedule' do    
      @client = Tendril::Client.new(:email => "jason@tendrilinc.com", 
                                    :password => "password", 
                                    :subdomain => "dev-program", :account_id => "Jenkins")
      @pricing = @client.pricing("schedule", :from => "2011-10-09T21:45:08-0500", :to => "2011-10-10T21:45:08-0500", :"external-account-id" => "Jenkins")
      @pricing["effectivePriceRecords"].size.should == 1
      @pricing["@startDate"].should == "2011-09-11T02:45:08Z"
    end
  end
  
  context "meter" do
    use_vcr_cassette 'meter'
    
    it "should request meter consumption" do
      @client = Tendril::Client.new(:email => "jason@tendrilinc.com", 
                                    :password => "password", 
                                    :subdomain => "dev-program", :account_id => "Jenkins")
      @meter = @client.meter("consumption", :from => "2010-05-09T21:45:08-0500", :to => "2010-10-10T21:45:08-0500", :"external-account-id" => "Jenkins")
      @meter["MeterReading"].size.should == 1
    end
    
    it "should request meter read" do
      @client = Tendril::Client.new(:email => "jason@tendrilinc.com", 
                                    :password => "password", 
                                    :subdomain => "dev-program", :account_id => "Jenkins")
      @meter = @client.meter("read", :from => "2010-05-09T21:45:08-0500", :to => "2010-06-09T21:45:08-0500", :"external-account-id" => "Jenkins")
      @meter["MeterReading"].first["Readings"].size.should == 96
    end
  end
end