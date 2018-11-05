class Event < ApplicationRecord
  belongs_to :project
  sync :all
  sync_touch :project
end
