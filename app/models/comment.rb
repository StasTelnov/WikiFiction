class Comment < Base::VersionModel
  belongs_to :article

  validates :author,
            :text,
            :rating,
            :presence => :true
  validates :rating, numericality: { :greater_than_or_equal_to => 0,
                                     :less_than_or_equal_to => 5 }

  after_update :update_article_rating, :if => :rating_changed?
  after_create :update_article_rating
  after_destroy :update_article_rating

  private

    def update_article_rating
      article.update_attributes({ :rating => article.comments.average(:rating) })
    end

end