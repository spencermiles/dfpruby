#!/usr/bin/env ruby

require "#{File.dirname(__FILE__)}/../lib/dfp"
require 'bacon'
require 'ruby-debug'

Bacon.summary_at_exit

ADVERTISER_ID = 1151
TRAFFICKER_ID = 7191

describe "A DFP LineItem" do
  it 'can create line items' do
    # Fetch an order
    order = DFP::Order.find_by_statement("LIMIT 1")
    order.class.should == DFP::Order
    
    line_item = DFP::LineItemService.create_line_item({
      :order_id => order.id,
      :name => "Test Line Item #{rand(999999999999)}",
      :start_date_time => DateTime.now + 100,
      :end_date_time => DateTime.now + 86400,
      :creative_rotation_type => "EVEN",
      :line_item_type => "STANDARD",
      :unit_type => 'IMPRESSIONS',
      :units_bought => 100,
      :cost_type => 'CPM',
      :cost_per_unit => {:currency_code => 'USD', :micro_amount => 200000},
      :creative_sizes => {:width => 300, :height => 250, :is_aspect_ratio => false},
      :targeting => {:inventory_targeting => {:targeted_ad_unit_ids => 123}}})
  end
end