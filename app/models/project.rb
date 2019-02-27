class Project < ActiveRecord::Base

	acts_as_mappable :default_units => :miles,
	                   :default_formula => :sphere,
	                   :distance_field_name => :distance,
	                   :lat_column_name => :latitude,
	                   :lng_column_name => :longitude

  belongs_to :user
  belongs_to :contractor

  has_many :declined_contractors, :class_name => "DeclinedProject", :foreign_key => "project_id"

  ## Below method to fetch all the contractors with in 5 miles radius
  def near_by_contractors
  	relation = Contractor.within(5, origin: [self.latitude, self.longitude])
    relation = relation.where("(#{self.min_budget} BETWEEN contractors.min_budget AND contractors.max_budget) OR (#{self.max_budget} BETWEEN contractors.min_budget AND contractors.max_budget)")
    relation = self.declined_contractors.blank? ? relation : relation.where.not(id: self.declined_contractors.pluck(:contractor_id))
    relation.order(rating: :desc)
  end

  ["pending", "assigned", "wip", "closed"].each do |proj_status|
    define_method "#{proj_status}?" do 
      self.status == proj_status
    end
  end

end
