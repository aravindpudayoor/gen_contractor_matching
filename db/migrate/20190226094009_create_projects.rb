class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
    	t.string :title
    	t.float :latitude
    	t.float :longitude
    	t.float :min_budget
    	t.float :max_budget
    	t.boolean :design_service
    	t.boolean :build_service
      t.string :status, default: "pending"
    	t.belongs_to :user
    	t.belongs_to :contractor

    	t.timestamps
    end
  end
end
