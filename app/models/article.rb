class Article < Base::VersionModel
  belongs_to  :category
  has_many    :comments, :dependent => :destroy

  include Filterable

  #===================== for ArticleFilter ========================>>>
  scope :title,               -> (title)                { where('LOWER(articles.title) LIKE ?', "#{title.downcase}%") }
  scope :author,              -> (author)               { where('LOWER(articles.author) LIKE ?', "#{author.downcase}%") }
  scope :category_ids,        -> (category_ids)         { where('articles.category_id IN (?)', category_ids) }
  scope :comments_count_from, -> (comments_count_from)  { where('comments.count >= ? ', comments_count_from) }
  scope :comments_count_to,   -> (comments_count_to)    { where('comments.count <= ?', comments_count_to) }
  scope :rating_from,         -> (rating_from)          { where('comments.rating >= ?', rating_from) }
  scope :rating_to,           -> (rating_to)            { where('comments.rating <= ?', rating_to) }

  def self.order_by(order)
    order("#{order[:order_column]} #{order[:direction]}")
  end
  #==================================================================

  validates :title,
            :author,
            :category_id,
            :text,
            :ip,
            :lock_version,
            :presence => true

  def update_with_conflict_validation(*args)
    update_attributes(*args)
  rescue ActiveRecord::StaleObjectError
    self.lock_version = lock_version_was
    errors.add(:base, 'This record was changed while you were editing.')
    changes.except('updated_at').each do |name, value|
      if name == 'category_id'
        errors.add(name, "was #{Category.find(value.first).name}")
      else
        errors.add(name, "was #{value.first}")
      end
    end
    false
  end

  def rating
    comments.average(:rating)
  end

  class << self

    def top(quantity)
      select_all_with_comments_count_and_rating.order('comments_rating DESC').limit(quantity)
    end

    def search(article_filter)
      select_all_with_comments_count_and_rating.filter(article_filter.filtering_params)
    end

    def joins_comments_count_and_rating
      joins(
          'INNER JOIN (
          SELECT article_id, AVG(comments.rating) AS rating, count(comments.article_id) AS count
          FROM comments GROUP BY comments.article_id) AS comments
          ON articles.id = comments.article_id'
      )
    end

    def select_all_with_comments_count_and_rating
      select('articles.*, comments.count AS comments_count, comments.rating AS comments_rating')
          .joins_comments_count_and_rating
    end

  end


end
