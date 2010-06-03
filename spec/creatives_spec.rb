#!/usr/bin/env ruby

require "#{File.dirname(__FILE__)}/../lib/dfp"
require 'bacon'
require 'ruby-debug'

Bacon.summary_at_exit

ADVERTISER_ID = 1151
TRAFFICKER_ID = 7191

describe "A DFP Creative" do
  it 'can create Creatives' do
    creative = DFP::CreativeService.create_creative_third_party({
      :advertiser_id => ADVERTISER_ID,
      :name => "Creative Test #{rand(9999999)}",
      :size => {:width => 300, :height => 250, :is_aspect_ratio => false},
      :destination_url => 'http://google.com',
      :snippet => '<b>AD</b>'
    })
    
    creative.class.should == DFP::Creative
    creative.name.should =~ /Creative Test/
    
    creative.snippet = 'FOOBAR'
    creative.save
  end
end