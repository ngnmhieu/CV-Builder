class Resume < ActiveRecord::Base
  belongs_to :user
  has_one    :personal_detail, dependent: :destroy
  has_many   :simplelists,     dependent: :destroy
  has_many   :multiline_lists, dependent: :destroy
  has_many   :textsections,    dependent: :destroy

  # for mass update
  accepts_nested_attributes_for :personal_detail, update_only: true
  accepts_nested_attributes_for :simplelists,     update_only: true
  accepts_nested_attributes_for :multiline_lists, update_only: true
  accepts_nested_attributes_for :textsections,    update_only: true

  include HasOrderableItems

  before_create :default_attributes

  def default_attributes
    self.name     ||= "Unnamed Resume"
    self.template ||= "default"
  end

  # all items in one array except for personal_detail
  # @return array
  def items
    items = self.simplelists + self.multiline_lists + self.textsections

    return items.sort_by { |item| item.order }
  end

end
