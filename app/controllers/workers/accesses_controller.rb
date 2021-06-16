class  Workers::AccessesController < ApplicationController
  before_action :authenticate_worker_admin!

  def show
    @workers = current_worker.company.workers.without(current_worker)
  end

  def update
    @worker = current_worker.company.workers.find(params[:id])

    if @worker.status.eql?("block")
      @worker.status = "released"
      @worker.save!

      redirect_to workers_access_path, alert: "#{t('accesses_unblock')}
                                               #{@worker.email}!"
    else
      @worker.status = "block"
      @worker.save!

      redirect_to workers_access_path, alert: "#{t('accesses_block')}
                                               #{@worker.email}!"
    end
  end
end
