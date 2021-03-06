class Admin::BaseController < ApplicationController
  before_action :required_admin

  private

    def required_admin
      redirect_to root_path unless current_user.admin?
    end
end
