namespace :populate do
  desc 'Populate authors'
  task :authors => :environment do
    100.times do
      Author.create! \
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
    end
  end

  desc 'Populate recipes'
  task :recipes => :environment do
    random = Random.new
    authors = Author.order('id desc').limit(100)
    100.times do
      author = authors.sample
      author.recipes.create \
        name:Faker::Food.dish,
        difficulty: (random.rand(5) + 1)
    end
  end

  task :'n-test' => :environment do
    Recipe.includes(:author).all.each do |recipe|
      puts recipe.author.first_name
    end
  end
end
