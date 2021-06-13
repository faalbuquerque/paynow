class Workers::CompaniesController < ApplicationController
  before_action :authenticate_worker!
  before_action :authenticate_worker_admin!, only: %i[ reset_token ]

  def show
    @company = current_worker.company
  end

  def reset_token
    @company = current_worker.company
    @company.create_token
    @company.save!

    respond_to do |format|
      format.js { render partial: 'reset_token' }
    end
  end
end
