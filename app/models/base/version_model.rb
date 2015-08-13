class Base::VersionModel < Base::Model
  self.abstract_class = true

  class << self
    def versionable_models
      @versionable_models ||= descendants.select { |child| !child.abstract_class }
    end
    alias :models :versionable_models

    def versionable_tables
      @versionable_tables ||= versionable_models.map(&:table_name)
    end
    alias :tables :versionable_tables
  end

end
