# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Interview do
  before(:each) do
    @valid_attributes = {
      job_application_id: 1,
      time: Time.current
    }
  end

  it "should create a new instance given valid attributes" do
    Interview.create!(@valid_attributes)
  end
end
