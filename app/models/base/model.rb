class Base::Model < ActiveRecord::Base
  self.abstract_class = true

  class << self

    def random_record
      self.offset(rand(self.count)).first
    end

    def random_record_id
      self.random_record.andand.id
    end

    def random_record_ids(limit)
      select('id').offset(rand(self.count)).limit(limit).sample(limit).map(&:id)
    end

  end

end
