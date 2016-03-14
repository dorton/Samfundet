# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GroupHelper do
  describe :abbreviate_long_name do
    before(:each) do
      @group = mock_model(Group)
      @group.stub(:abbreviation).and_return("LIM")
    end

    context "group name is too loong" do
      before(:each) do
        @group.stub(:name).and_return("Layout Info Marked With Too Long Name HAHA")
        @html = helper.abbreviate_long_name(@group)
      end

      it "should return abbreviation" do
        @html.should have_selector("abbr", content: "LIM")
      end

      it "should have full name in title attribute" do
        @html.should have_selector("abbr[title='#{@group.name}']")
      end
    end

    context "group name is below the limit" do
      before(:each) do # TODO: DRY up
        @group.stub(:name).and_return("Layout Info Marked")
        @html = helper.abbreviate_long_name(@group)
      end

      it "should return full name" do
        @html.should == @group.name
      end
    end

    context "group have HTML-code in name or abbreviation" do
      before(:each) do
        @group.stub(:name).and_return("<blink>Layout Info Marked</blink>")
        @group.stub(:abbreviation).and_return("<blink>LIM</blink>")
      end

      it "should HTML-escape name and abbreviaton when abbreviated " do
        @html = helper.abbreviate_long_name(@group, limit: 1)
        @html.should_not have_selector("blink")
      end

      it "should HTML-escape name and abbreviaton when not abbreviated " do
        @html = helper.abbreviate_long_name(@group, limit: 1000)
        @html.should_not have_selector("blink")
      end
    end
  end
end
