class Post < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :attachments, :as => :container, dependent: :destroy
  validates :body, :presence => true, length: { maximum: 200 }
  accepts_nested_attributes_for :attachments
  acts_as_readable on: :created_at
  sync :all
  sync_touch :project, :user

  def get_color
  	user = User.find(user_id)
    
  	if user.is_a? Client
  	  return "#0079bf"
  	elsif user.is_a? Employee
  	  return "#F80602"
  	else
  	  return "#F5E106"
  	end
  	return "white"
  end

  def is_owned?(user)
  	(user.id == user_id ? true : false)
  end

end
