class Migration::TableMigration < Migration::BaseMigration

  def extend_create_table_block(table_name, options = {}, &block)
    -> (t) do
      yield t
      t.timestamps :null => false
    end
  end

end