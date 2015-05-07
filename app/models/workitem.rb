class Workitem < ActiveRecord::Base
  belongs_to :worklist
  liquid_methods :line1, :line2, :desc, :start, :end

  after_initialize :default_attributes

  def default_attributes
    self.line1 ||= ''
    self.line2 ||= ''
    self.desc  ||= ''
    self.start ||= DateTime.now 
    self.end   ||= DateTime.now 
    self.order ||= self.worklist.items.size + 1
  end

  def self.find_and_save(id,params)

    item = self.find(id)

    item.order = params[:order]
    item.line1 = params[:line1]
    item.line2 = params[:line2]
    item.desc = params[:desc]

    start_year= params['start(1i)'].to_i
    start_month = params['start(2i)'].to_i
    start_day = params['start(3i)'].to_i
    item.start = Date.new(start_year, start_month, start_day)

    end_year= params['end(1i)'].to_i
    end_month = params['end(2i)'].to_i
    end_day = params['end(3i)'].to_i
    item.end = Date.new(end_year, end_month, end_day)

    item.save
  end
end
