FactoryGirl.define do
  factory :resume do 
    name "Test Resume"
  end

  factory :resume_with_items, class: Resume do
    name "Test Resume"

    after(:create) do |resume|
      item_klasses = [Simplelist, Worklist, Textsection]
      (1..10).each do |i|
        klass   = item_klasses[rand(3)].to_s
        method  = klass.downcase.pluralize
        factory = klass.downcase.to_sym
        resume.send(method) << create(factory, name: "#{klass} #{i}", order: i) 
      end
    end
  end
end
