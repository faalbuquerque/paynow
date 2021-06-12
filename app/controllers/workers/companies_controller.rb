class Workers::CompaniesController < ApplicationController
  before_action :authenticate_worker!

  def show
    @company = current_worker.company
  end
end