class Comment < Base::VersionModel
  belongs_to :article

  validates :author,
            :text,
            :rating,
            :presence => :true
  validates :rating, numericality: { :greater_than_or_equal_to => 0,
                                     :less_than_or_equal_to => 5 }
end
