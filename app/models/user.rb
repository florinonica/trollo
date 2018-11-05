class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable, authentication_keys: [:login]
  has_attached_file :avatar, :styles => {:large => "750x750>", :medium => "300x300>", :thumb => "100x100#" }, :default_url => "generic.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :username, uniqueness: true
  has_many :attachments, dependent: :destroy
  has_many :bugs, foreign_key: :tester_id
  has_many :posts, dependent: :destroy
  has_many :project_workers, dependent: :destroy
  has_many :projects, through: :project_workers
  has_many :reports, foreign_key: :owner_id
  has_many :tasks, foreign_key: :dev_id
  has_many :tickets, foreign_key: :owner_id
  has_and_belongs_to_many :reports, join_table: :users_reports
  acts_as_reader
  sync :all

  before_create :set_type

  enum type: {'Superuser' => 0, 'Employee' => 1, 'Client' => 2}

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(search)
    (search=="All" ? all : where('type LIKE ?', "%#{search}%"))
  end

  attr_accessor :role_ids

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["username = :value OR email = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def get_projects
    (type == "Superuser" ? Project.all : projects)
  end

  def can_see_projects?
    true
  end

  def can_create_project?
    false
  end

  def can_edit_project?
    false
  end

  def can_delete_project?
    false
  end

  def can_see_all_users?
    false
  end

  def can_create_user?
    false
  end

  def can_edit_user?
    false
  end

  def can_delete_user?
    false
  end

  def can_add_clients?
    false
  end

  def can_change_manager?
    false
  end

  def can_assign_employees?(id)
    false
  end

  def can_see_project_details?
    false
  end

  def can_see_employees?
    false
  end

  def can_alter_ticket?(ticket)
    false
  end

  def can_delete_ticket?(ticket)
    false
  end

  def is_manager?(id)
    false
  end

  def is_dev?(id)
    false
  end

  def is_tester?(id)
    false
  end

  def can_add_subtask_or_bug?(ticket)
    false
  end

  def can_have_roles?
    false
  end

  def can_comment?
    false
  end

  def can_edit_comment?(id)
    false
  end

  def can_delete_comment?(id)
    false
  end

  def can_delete_attachment?(attachment)
    false
  end

  def can_add_attachment?
    false
  end

  def is_client?(project)
    false
  end

  def can_undo?
    true
  end

  def can_change_report_availability?
    false
  end

  def can_create_report?(project)
    false
  end

  def can_see_report?(report)
    false
  end

  def can_create_complex_report?
    false
  end

  def can_see_all_charts?(project)
    false
  end

  def get_unread_ticket_messages_count
    count = 0
    tickets.each do |t|
      count += t.comments.select{|c| c.unread?(self)}.count
    end

    if tasks.any?
      tasks.each do |t|
        count += t.comments.select{|c| c.unread?(self)}.count
      end
    end
    count
  end

  def get_unread_project_messages_count
    count = 0
    get_projects.each do |p|

      if is_manager?(p.id)
        count += p.posts.select{|post| post.unread?(self)}.count
      end
    end
    count
  end

  def get_unread_messages_count
    get_unread_project_messages_count + get_unread_ticket_messages_count
  end

  def get_unread_ticket_messages
    messages = []
    tickets.each do |t|

      if t.comments.select{|c| c.unread?(self)}.any?
        messages.push(t)
      end
    end

    if tasks.any?
      tasks.each do |t|

        if t.comments.select{|c| c.unread?(self)}.any?
          messages.push(t)
        end
      end
    end
    messages
  end

  def get_unread_project_messages
    messages = []
    get_projects.each do |p|

      if (is_manager?(p.id)) && p.posts.select{|post| post.unread?(self)}.any?
        messages.push(p)
      end
    end
    messages
  end

  private

    def set_type
      self.type = self.class.name
    end

end
