# -*- encoding : utf-8 -*-
require 'spec_helper'

describe RolesController do
  describe :show do
    it "should assign @role" do
      @role = create_role("lim")

      get :show, id: @role.id
      assigns[:role].should == @role
    end
  end

  describe :index do
    it "should assign @roles with the existing roles" do
      @role = create_role("lim")

      get :index
      assigns[:roles].should == [@role]
    end
  end

  describe :new do
    it "should return new record" do
      get :new
      assigns[:role].should be_new_record
    end
  end

  describe :create do
    describe "success" do
      before(:each) do
        @role = mock_model(Role).as_null_object
        @role.should_receive(:save).and_return(true)

        Role.should_receive(:new).at_least(:once).and_return(@role)
        post :create
      end

      it "should redirect to role page for that role" do
        response.should redirect_to(role_path(@role))
      end

      it "should set success flash" do
        flash[:success].should_not be_nil
      end
    end

    describe "failure" do
      before(:each) do
        @role = mock_model(Role).as_null_object
        @role.should_receive(:save).and_return(false)

        Role.should_receive(:new).at_least(:once).and_return(@role)
        post :create
      end

      it "should assign role" do
        assigns[:role].should == @role
      end

      it "should set error flash" do
        flash[:error].should_not be_nil
      end

      it "should re-render role creation form" do
        response.should render_template(:new)
      end
    end
  end

  describe :update do
    before(:each) do
      @role = create_role("lim")
    end

    describe "success" do
      before(:each) do
        Role.should_receive(:find_by_id).at_least(:once).and_return(@role)
        @role.should_receive(:update_attributes).and_return(true)
        post :update, id: @role.id
      end

      it "should redirect to role page for that role" do
        response.should redirect_to(role_path(@role))
      end

      it "should set success flash" do
        flash[:success].should_not be_nil
      end
    end

    describe "failure" do
      before(:each) do
        Role.should_receive(:find_by_id).at_least(:once).and_return(@role)
        @role.should_receive(:update_attributes).and_return(false)

        post :update, id: @role.id
      end

      it "should assign role" do
        assigns[:role].should == @role
      end

      it "should set error flash" do
        flash[:error].should_not be_nil
      end

      it "should re-render role edit form" do
        response.should render_template(:edit)
      end
    end
  end

  describe :pass do
    before(:each) do
      Role.stub(:find).with(:all).and_return([])

      @member = mock_model(Member)
      session[:member_id] = @member.id
      Member.should_receive(:find).at_least(:once).and_return(@member)

      @role = mock_model(Role)
      Role.should_receive(:find).with(@role.id.to_s).and_return(@role)

      @members_role = mock_model(MembersRole)
      @members_role.should_receive(:destroy)
      MembersRole.should_receive(:find).and_return(@members_role)
      MembersRole.should_receive(:create)

      post :pass, id: @role.id, member_id: @member.id
    end

    it "should redirect back to the control panel" do
      response.should redirect_to(members_control_panel_path)
    end

    it "should set success flash" do
      flash[:success].should_not be_nil
    end
  end
end
