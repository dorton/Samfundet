# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GroupType do
  it_should_validate_presence_of :description

  it "should be ordered by order field" do
    types = [2, 3, 1, 3, 4].collect { |n| GroupType.new(priority: n) }
    types.sort.collect(&:priority).should == [1, 2, 3, 3, 4]
  end
end
