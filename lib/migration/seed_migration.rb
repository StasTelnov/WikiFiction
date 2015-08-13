class Migration::SeedMigration < Migration::BaseMigration

  def extend_create_table_block(table_name, options = {}, &block)
    ->(t) do
      yield(t)
      t.string :name_en, :null => false, :limit => 255
      t.string :code,    :null => false, :limit => 255
    end
  end

end
