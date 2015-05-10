class Resume < ActiveRecord::Base
  belongs_to :user
  belongs_to :template
  has_one    :personal_detail, dependent: :destroy
  has_many   :simplelists,     dependent: :destroy
  has_many   :worklists, dependent: :destroy
  has_many   :textsections,    dependent: :destroy

  # for mass update
  accepts_nested_attributes_for :personal_detail, update_only: true
  accepts_nested_attributes_for :simplelists,     update_only: true
  accepts_nested_attributes_for :worklists,       update_only: true
  accepts_nested_attributes_for :textsections,    update_only: true

  include HasOrderableItems

  before_create :default_attributes

  def default_attributes
    self.name     ||= "Unnamed Resume"
    self.template ||= Template.default
  end

  # all items in one array except for personal_detail
  # @return array
  def items
    items = self.simplelists + self.worklists + self.textsections

    return items.sort_by { |item| item.order }
  end

  def add_item(item)
    return nil unless item.respond_to?(:resume=) && item.respond_to?(:order=)

    item.resume = self 
    item.order = self.items.size + 1

    return item.save ? item : nil
  end

  def update_resume(params)

    # attributes of resume
    resume = params
    self.name = resume[:name]
    self.template = Template.find(resume[:template_id]) 

    self.save

    # attributes for personal detail
    self.personal_detail.save_attributes(params[:personal_detail_attributes])

    # save the worklists
    worklists = params[:worklists_attributes] || []
    worklists.each do |list_id, worklist|
      Worklist.find_and_save(list_id, worklist)

      workitems = worklist[:workitems_attributes] || []
      workitems.each do |item_id, workitem|
        Workitem.find_and_save(item_id, workitem)
      end
    end
    
    # save the simplelists
    simplelists = params[:simplelists_attributes] || []
    simplelists.each do |list_id, simplelist|
      Simplelist.find_and_save(list_id, simplelist)

      simpleitems = simplelist[:simpleitems_attributes] || []
      simpleitems.each do |item_id, simpleitem|
        Simpleitem.find_and_save(item_id, simpleitem)
      end
    end

    # save textsection
    textsections = params[:textsections_attributes] || []
    textsections.each do |sec_id, textsection|
      Textsection.find_and_save(sec_id, textsection)
    end

  end
end
