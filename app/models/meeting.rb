class Meeting < ActiveRecord::Base
  attr_accessible :id, :address, :city, :codes, :day, :map, :name, :notes, :created_at, :updated_at

  # for AJAX search #
  validates_presence_of :name
  validates_presence_of :day
  validates_presence_of :city
  validates_presence_of :codes
  validates_presence_of :address
  # 
  
  def self.to_csv( options = {})
  	CSV.generate(options) do |csv|
  		csv << column_names
  		all.each do |meeting|
  			csv << meeting.attributes.values_at(*column_names)
  		end
  	end
  end

  def self.import(file)
	CSV.foreach(file.path, headers: true) do |row|
  		meeting = find_by_id(row["id"]) || new
	#	Meeting.create! row.to_hash
		meeting.attributes = row.to_hash.slice(*accessible_attributes)
		meeting.save!
  	end
  end
end
