class Role < ApplicationRecord
  has_many :project_workers
  has_and_belongs_to_many :employee, join_table: :employee_roles
end
