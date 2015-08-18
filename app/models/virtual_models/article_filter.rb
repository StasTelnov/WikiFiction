class ArticleFilter < Filter

  attr_accessor :title,
                :author,
                :rating_from,
                :rating_to,
                :comments_count_from,
                :comments_count_to,
                :category_ids,
                :order_column,
                :direction,
                :created_from,
                :created_to

  def filtering_keys
    %w(title author category_ids comments_count_from comments_count_to rating_from rating_to created_from created_to order_by)
  end

  def category_ids=(category_ids)
    @category_ids = category_ids.reject(&:blank?).map(&:to_i)
  end

  def rating_from=(rating_from)
    @rating_from = rating_from.to_f unless rating_from.blank?
  end

  def rating_to=(rating_to)
    @rating_to = rating_to.to_f unless rating_to.blank?
  end

  def comments_count_from=(comments_count_from)
    @comments_count_from = comments_count_from.to_i unless comments_count_from.blank?
  end

  def comments_count_to=(comments_count_to)
    @comments_count_to = comments_count_to.to_i unless comments_count_to.blank?
  end

  def created_from=(created_from)
    @created_from = created_from.to_date unless created_from.blank?
  end

  def created_to=(created_to)
    @created_to = created_to.to_date unless created_to.blank?
  end

  def order_column=(order_column)
    @order_column = order_column unless order_column.blank?
  end

  def order_by
    if order_column.present?
      {
          :order_column => order_column,
          :direction => direction
      }
    end
  end

end