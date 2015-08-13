namespace :demo do

  desc 'Create Demo Data'
  task :seed => :environment do
    # Foo_model.skip_callback(:create, :after, :foo_method)

    {
        :article_with_comments => 25
    }.each do |key, count|
      count.times { FactoryGirl.create(key) }
      puts "[#{key}] was populated with demo data"
    end

  end

  desc 'Clear Demo Data'
    task :clear => :environment do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start
  end

end