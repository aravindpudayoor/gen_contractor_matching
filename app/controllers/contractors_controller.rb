class ContractorsController < ApplicationController
  before_action :authenticate_contractor!
  before_action :get_contractor

  def edit_profile
  end

  def update_profile
  	if @contractor.update(contra_params)
      redirect_to edit_profile_contractors_path(id: @contractor.id), success: 'Updated Successfully'
    end
  end

  def my_projects
    @projects = @contractor.projects
  end
  
  def accept_project
    @project = Project.find(params[:id])
    if params[:status] == 'accepted'
      @project.update_attributes(status: 'wip')
    else
      @project.update_attributes(status: 'pending', contractor: nil)
      DeclinedProject.create(project: @project, contractor: @contractor)
    end
    redirect_to my_projects_contractors_path, success: "Project #{params[:status]} Successfully"
  end

  private

  def get_contractor
    @contractor = current_contractor
  end

  def contra_params
    params.require(:contractor).permit(
    :name,
    :latitude,
    :longitude,
    :min_budget,
    :max_budget,
    :offers_design_service,
    :offers_build_service
    )
  end
  
end
