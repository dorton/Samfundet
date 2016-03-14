# -*- encoding : utf-8 -*-
require 'spec_helper'

describe JobTag do
  before(:each) do
    @valid_attributes = {
      title: "value for title"
    }
  end

  it "should create a new instance given valid attributes" do
    JobTag.create!(@valid_attributes)
  end
end
