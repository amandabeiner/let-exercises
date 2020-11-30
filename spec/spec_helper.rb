require "rspec"
require "active_record"
require "database_cleaner"
require "factory_bot"
require "pry"

PROJECT_ROOT = File.expand_path("../..", __FILE__)
$LOAD_PATH << PROJECT_ROOT

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: File.join(PROJECT_ROOT, "test.db")
)

class CreateSchema < ActiveRecord::Migration[4.2]
  def self.up
    create_table :restaurant_owners, force: true do |t|
      t.string :name
      
      t.timestamps
    end

    create_table :restaurants, force: true do |t|
      t.string :name, null: false
      t.string :address
      t.integer :max_capacity, null: false

      t.belongs_to :restaurant_owner

      t.timestamps
    end
  end
end

FactoryBot.define do
  factory :restaurant do
    name { "Stella's" }
    restaurant_owner

    trait :with_address do
      address {"123 Main Street, Boston, MA 02122" }
    end
  end

  factory :restaurant_owner do
    name { "Stella Smith" }
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    CreateSchema.suppress_messages { CreateSchema.migrate(:up) }
    DatabaseCleaner.clean_with :deletion
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do 
    DatabaseCleaner.start
  end

  config.after(:each) do 
    DatabaseCleaner.clean
  end
end
