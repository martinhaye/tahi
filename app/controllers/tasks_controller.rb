class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin!, except: [:show, :update, :update_participants]
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def index
    @paper = Paper.includes(:journal, :phases => :tasks).find(params[:id])
    respond_to do |format|
      format.html
      format.json do
        @phases = @paper.phases
      end
    end
  end

  def update
    task = if current_user.admin?
             Task.where(id: params[:id]).first
           else
             current_user.tasks.where(id: params[:id]).first
           end

    tp = task_params(task)

    if task && task.authorize_update!(tp, current_user)
      task.update tp
      respond_with task
    else
      head :forbidden
    end
  end

  def create
    task = build_task
    if task.persisted?
      respond_with task, location: task_url(task)
    else
      render status: 500
    end
  end

  def show
    @task = Task.find(params[:id])
    respond_to do |f|
      f.json { render json: @task }
      f.html { render 'ember/index' }
    end
  end

  def destroy
    task_temp = Task.find(params[:id])
    task = PaperPolicy.new(task_temp.paper, current_user).tasks_for_paper(params[:id]).first
    if task && task.destroy
      render json: true
    else
      render status: 400
    end
  end

  private

  def task_params(task = nil)
    attributes = [:assignee_id, :completed, :title, :body, :phase_id, :type]
    attributes += task.class::PERMITTED_ATTRIBUTES if task
    params.require(:task).permit(*attributes)
  end

  def build_task
    task_type = task_params[:type]
    sanitized_params = task_params task_type.constantize.new
    TaskFactory.build_task task_type, sanitized_params, current_user
  end

  def render_404
    head 404
  end
end
