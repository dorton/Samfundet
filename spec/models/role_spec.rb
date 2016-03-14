# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Role do
  describe "title validation" do
    it "should allow alphanumeric characters and underscore" do
      role = Role.new(title: "a_valid_role_123", name: "Dummy name", description: "Dummy description.")
      role.should be_valid
    end

    it "should require a presence of name" do
      role = Role.new(title: "not_valid_role", description: "not_valid_role")
      role.should_not be_valid
    end

    it "should require a presence of description" do
      role = Role.new(title: "not_valid_role", name: "not_valid_role")
      role.should_not be_valid
    end
  end
end
