class Attachment < ApplicationRecord
  belongs_to :user
  belongs_to :container, :polymorphic => true
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => [/\Aimage\/.*\Z/, /\Avideo\/.*\Z/, /\Aaudio\/.*\Z/, /\Aapplication\/.*\Z/]


  def is_video?
    file_content_type =~ %r(video)
  end

  def is_image?
    file_content_type =~ %r(image)
  end

  def is_audio?
    file_content_type =~ %r(audio)
  end
end
