class Friend < ApplicationRecord
  has_many :blogs, dependent: :delete_all

end
