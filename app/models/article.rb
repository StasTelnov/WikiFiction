class Article < Base::VersionModel
  belongs_to  :category
  has_many    :comments, :dependent => :destroy

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
    comments.average(:rating) || 0
  end
end
