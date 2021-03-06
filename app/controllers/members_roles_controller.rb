# -*- encoding : utf-8 -*-
class MembersRolesController < ApplicationController
  before_filter :before_create, only: :create
  filter_access_to [:create, :destroy], attribute_check: true

  def destroy
    @members_role.destroy
    flash[:success] = "Medlemmet er slettet."
    redirect_to role_path(@members_role.role)
  end

  def create
    if @members_role.role.members.include? @members_role.member
      flash[:error] = "Medlemmet har allerede denne rollen."
      redirect_to role_path(@members_role.role)
    else
      @members_role.save!
      flash[:success] = "Medlemmet er lagt til."
      redirect_to role_path(@members_role.role)
    end
  end

  private

  def before_create
    @members_role = MembersRole.new(
      member: Member.find(params[:member_id].to_i),
      role: Role.find(params[:role_id].to_i)
    )
  end
end
