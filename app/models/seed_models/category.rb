class Category < Base::SeedModel
  has_many :articles, :dependent => :destroy
end
