#!/usr/bin/env ruby

require "#{File.dirname(__FILE__)}/../lib/dfp"
require 'bacon'
require 'ruby-debug'

Bacon.summary_at_exit

ADVERTISER_ID = 1151
TRAFFICKER_ID = 7191

describe "A DFP Order" do
  it 'can create orders' do
    order = DFP::OrderService.create_order({:name => "Test #{rand 9999999999999999999}", :advertiserId => ADVERTISER_ID, :traffickerId => TRAFFICKER_ID})
    order.class.should == DFP::Order
    order.advertiser_id.to_i.should == ADVERTISER_ID
    order.trafficker_id.to_i.should == TRAFFICKER_ID
    @order_id = order.id.to_i
  end
  
  it 'can create an order via the Order model' do
    order = DFP::Order.new(:name => "Test #{rand 99999999999}", :advertiser_id => ADVERTISER_ID, :trafficker_id => TRAFFICKER_ID)
    order.save

    order.class.should == DFP::Order
    order.id.to_i.should >= 1
  end
  
  it 'can get an order' do
    order = DFP::OrderService.get_order(@order_id)
    order.class.should == DFP::Order
    order.advertiser_id.to_i.should == ADVERTISER_ID
  end
  
  it 'can get orders by statement' do
    order = DFP::OrderService.get_orders_by_statement("WHERE id=#{@order_id}")
    order.class.should == DFP::Order
    order.id.to_i.should == @order_id
    
    order = DFP::Order.find_by_statement("WHERE id IN (#{@order_id})")

    order.id.to_i.should == @order_id
  end
  
  it "can update an order" do
    order = DFP::OrderService.get_orders_by_statement("WHERE id=#{@order_id}")
    order.id.to_i.should == @order_id
    order.notes = "THIS IS ONLY A TEST"
    order.save

    # Fetch the order to verify that it was actually updated
    updated_order = DFP::Order.find(@order_id)
    updated_order.notes.should == order.notes
  end
end