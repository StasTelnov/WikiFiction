module Translate

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def translate(*columns)
      define_method "get_translate_columns" do
        columns.to_a
      end

      columns.each do |column|

        define_method column do
          self[self.class.column_translated(column)]
        end

        define_method "#{column}=" do |value|
          self[self.class.column_translated(column)] = value
        end

      end
    end

    def column_translated(name)
      column_name = "#{name}_#{I18n.locale}"
      self.column_names.include?(column_name) ? column_name : "#{name}_#{I18n.default_locale}"
    end
  end

end

ActiveRecord::Base.send :include, Translate
