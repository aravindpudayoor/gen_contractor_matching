class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :get_project, only: [:edit, :update, :near_by_contractors]

  def index
  	@projects = Project.all
  end

  def my_projects
  	@projects = current_user.projects
  end

  def new
  	@project = Project.new
  end

 	def create
 		@project = Project.create(project_params)
 		if @project.update_attributes(user: current_user)
 			redirect_to my_projects_projects_path, success: 'Successfully created project'
 		end
 	end

 	def edit
 	end

 	def update
 		@project.update(project_params)
 		redirect_to my_projects_projects_path, success: 'Successfully updated project'
 	end

 	def near_by_contractors
 		@contractors = @project.near_by_contractors
 	end

 	def assign_contractor
 		@project = Project.find(params[:project])
 		@contractor = Contractor.find(params[:contractor])
 		@project.update_attributes(contractor: @contractor, status: 'assigned')
 		redirect_to my_projects_projects_path, success: "Successfully assiged project to #{@contractor.email}"
 	end
  
  private

  def get_project
  	@project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(
    :title,
    :latitude,
    :longitude,
    :min_budget,
    :max_budget,
    :design_service,
    :build_service
    )
  end
end
