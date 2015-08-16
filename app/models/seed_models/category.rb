class Category < Base::SeedModel
  has_many :articles, :dependent => :destroy

  attr_accessor :checked
end
