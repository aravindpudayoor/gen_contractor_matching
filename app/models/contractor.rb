class Contractor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	
	acts_as_mappable :default_units => :miles,
	                   :default_formula => :sphere,
	                   :distance_field_name => :distance,
	                   :lat_column_name => :latitude,
	                   :lng_column_name => :longitude
	                            
  has_many :projects
  has_many :declined_projects, :class_name => "DeclinedProject", :foreign_key => "contractor_id"
end
