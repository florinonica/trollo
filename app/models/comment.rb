class Comment < ApplicationRecord
  validates :body, :presence => true, length: { maximum: 200 }
  belongs_to :user
  belongs_to :ticket
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :attachments, :as => :container, dependent: :destroy
  accepts_nested_attributes_for :attachments
  acts_as_readable on: :created_at
  sync :all
  sync_touch :ticket, :user
end
