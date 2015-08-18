class CreateArticles < Migration::TableMigration
  def change
    create_table :articles do |t|
      t.references  :category,      :null => false, :index => true
      t.text        :text,          :null => false
      t.string      :title,         :null => false
      t.string      :author,        :null => false
      t.inet        :ip,            :null => false
      t.float       :rating,        :null => false, :default => 0
      t.integer     :lock_version,  :null => false, :default => 0

      t.foreign_key :categories
    end
    add_index :articles, :title
    add_index :articles, :author
    add_index :articles, :ip
  end
end
