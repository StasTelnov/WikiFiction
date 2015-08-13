# a bit of error-proofing for migration classes (inherit from BaseMigration child classes whenever possible)
module MigrationInheritanceControl
  include ::BaseInheritanceControl

  AR_MIGRATION_CHILDREN_NAMES = %w(Migration::BaseMigration)

  def inherited(child_class)
    super
    inherited_extension(child_class, AR_MIGRATION_CHILDREN_NAMES, 'custom model')
  end
end

ActiveRecord::Migration.send(:extend, MigrationInheritanceControl)