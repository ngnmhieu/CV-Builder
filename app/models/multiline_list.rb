class MultilineList < ActiveRecord::Base
  belongs_to :resume
  has_many :multiline_list_items, dependent: :destroy

  accepts_nested_attributes_for :multiline_list_items, update_only: true
end
