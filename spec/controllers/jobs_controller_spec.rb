# -*- encoding : utf-8 -*-
require 'spec_helper'

describe JobsController do
  describe :show do
    before(:each) do
      @similar_job = stub_model(Job)

      @job = stub_model(Job)
      @admission = stub_model(Admission)
      @admission.should_receive(:appliable?).and_return(true)
      @job.stub(:admission).and_return(@admission)
      @job.stub(:group).and_return(stub_model(Group))
      @job.stub(:similar_available_jobs).and_return [@similar_job]
      @job.stub(:available_jobs_in_same_group).and_return [@similar_job]

      Job.stub(:find).and_return(@job)
    end

    it "should assign @job" do
      get :show, id: @job.id
      assigns[:job].should == @job
    end

    it "should assign @similar_available_jobs" do
      get :show, id: @job.id
      assigns[:similar_available_jobs].should == [@similar_job]
    end

    it "should assign @available_jobs_in_same_group" do
      get :show, id: @job.id
      assigns[:available_jobs_in_same_group].should == [@similar_job]
    end

    describe "when not yet applied" do
      before(:each) do
        get :show, id: @job.id
      end

      it "should assign @job_application to a new record" do
        assigns[:job_application].should be_new_record
      end

      it "should associate @job_application with @job" do
        assigns[:job_application].job.should == @job
      end

      it "should not save the new @job_application" do
        @job.job_applications.all.should be_empty
      end
    end

    describe "when already applied" do
      before(:each) do
        @applicant = create_applicant
        @job_app = JobApplication.create(applicant: @applicant, job: @job, motivation: "Just because")

        session[:applicant_id] = @applicant.id
        get :show, id: @job.id
      end

      it "should assign @job_application to existing application" do
        assigns[:job_application].should == @job_app
      end
    end
  end
end
