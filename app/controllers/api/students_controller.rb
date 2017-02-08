class Api::StudentsController < ApplicationController

  before_action :validate_token

  respond_to :json

  def index
    students = if params[:section_id]
                 current_user.sections.find(params[:section_id]).students
               else
                 current_user.courses.find(params[:course_id]).students
               end
    render json: students.order(:sortable_name)
  end

end
