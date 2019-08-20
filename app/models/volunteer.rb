class Volunteer < ApplicationRecord
  belongs_to :organization, optional: true
end
