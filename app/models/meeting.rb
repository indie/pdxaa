# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  day        :string(255)
#  name       :string(255)
#  address    :string(255)
#  city       :string(255)
#  codes      :string(255)
#  map        :string(255)
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meeting < ActiveRecord::Base
  attr_accessible :id, :address, :city, :codes, :day, :map, :name, :notes, :created_at, :updated_at

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

  def self.pagination(page, sort = nil, dir = 'ASC')
    paginate :page => page, :per_page => 700, :order => sort ? "#{sort} #{dir}" : 'day, name ASC'
  end

end