class Friend < ApplicationRecord
  has_many :blogs, dependent: :destroy
  accepts_nested_attributes_for :blogs,  reject_if: :all_blank, allow_destroy: true

end
