# -*- encoding : utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

share_examples_for "login with pending application" do
  context "when pending application" do
    before(:each) do
      @application = JobApplication.new(job: mock_model(Job), motivation: "Just because")
      session[:pending_application] = @application
    end

    it "should set the applicant" do
      post_create
      @application.applicant.should == @applicant
    end

    it "should save the application" do
      @application.should_receive(:save)
      post_create
    end

    it "should redirect to the application list" do
      post_create
      response.should redirect_to(job_applications_path)
    end

    it "should clear the pending application" do
      post_create
      session[:pending_application].should be_nil
    end

    it "should reset the cached current_user" do
      post_create
      controller.current_user.should == @applicant
    end
  end
end
