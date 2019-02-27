class CreateDeclinedProjectContractor < ActiveRecord::Migration
  def change
    create_table :declined_project_contractors do |t|
    	t.belongs_to :project
    	t.belongs_to :contractor
    end
  end
end
