class DeclinedProject < ActiveRecord::Base

  self.table_name =  "declined_project_contractors"

  belongs_to :project
  belongs_to :contractor

end
