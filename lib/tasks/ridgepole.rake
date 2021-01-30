# frozen_string_literal: true

namespace :ridgepole do
  desc 'Apply migration to database in development environment'
  task apply: :environment do
    system('bundle exec ridgepole -c config/database.yml -f db/Schemafile -E development -a')
    Rake::Task['db:schema:dump'].invoke if Rails.env.development?
    Rake::Task['annotate_models'].invoke if Rails.env.development?
  end
end
