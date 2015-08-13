# a bit of error-proofing for model classes (inherit from BaseModel child classes whenever possible)
module ModelInheritanceControl
  include ::BaseInheritanceControl

  AR_BASE_CHILDREN_NAMES = %w(Base::Model)

  def inherited(child_class)
    super
    inherited_extension(child_class, AR_BASE_CHILDREN_NAMES, 'custom model')
  end
end

ActiveRecord::Base.send(:extend, ModelInheritanceControl)