module BaseInheritanceControl
  def inherited_extension(child_class, klasses, allowed_classes)
    return unless child_class.name

    unless child_class.name.start_with?('ActiveRecord::') || klasses.include?(child_class.name) || (child_class.ancestors.map(&:name) & klasses).any?
      raise exception_message(child_class, allowed_classes)
    end
  end

  private

    def exception_message(child_class, allowed_classes)
      "#{child_class.name} mistakenly inherits from #{self.name} - use one of #{allowed_classes} classes " <<
          "as parent for #{child_class.name}\n"
    end

end