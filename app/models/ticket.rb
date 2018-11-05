class Ticket < ApplicationRecord
  validates :title, :presence => true, length: { in: 3..50 }
  validates :description, :presence => true, length: { in: 10..1000 }
  belongs_to :project
  belongs_to :owner, class_name: "User"
  belongs_to :dev, class_name: "User", optional: true
  belongs_to :task, class_name: "Ticket", optional: true
  has_many :comments, foreign_key: :ticket_id, dependent: :destroy
  has_many :subtasks, class_name: "Task", foreign_key: :task_id, dependent: :destroy
  has_many :bugs, class_name: "Bug", foreign_key: :task_id, dependent: :destroy
  has_many :attachments, :as => :container, dependent: :destroy
  has_paper_trail on: [:update]
  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :comments

  before_create :set_type

  enum type: {'Task' => 0, 'Bug' => 1}

  def self.search(search,user)

    if search == "All"
      return all
    elsif search == "Only mine - Dev"
      return where('dev_id LIKE ?', "%#{user.id}%")
    elsif search == "Only mine - Owner"
      return where('owner_id LIKE ?', "%#{user.id}%")
    else
      return where('type LIKE ?', "%#{search}%")
    end
  end

  def get_owner
    User.find(owner_id)
  end

  def get_dev
    User.find(dev_id)
  end

  def get_colour
  	case priority
  	when "High"
  		return "#F81115"
  	when "Medium"
  		return "#F9EC02"
  	when "Low"
  		return "#0BA6BB"
  	else
  		return "#fff"
  	end
  end

  def get_class_colour
    "#198DE8"
  end

  def get_glyph
    "glyphicon glyphicon-tasks"
  end

  def get_versions_count
    versions.size
  end

  private

    def set_type
      self.type = self.class.name
    end

end
