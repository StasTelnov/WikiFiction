class CreateComments < Migration::TableMigration
  def change
    create_table :comments do |t|
      t.references  :article, :null => false, :index => true
      t.text        :text,    :null => false
      t.string      :author,  :null => false
      t.float       :rating,  :null => false, :default => 0

      t.foreign_key :articles
    end
  end
end
