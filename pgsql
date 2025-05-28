# Directory Structure

my_football_api/
├── .github/
│   ├── workflows/
│   │   └── ci.yml
│   └── dependabot.yml
├── app/
│   ├── channels/
│   │   └── application_cable/
│   │       ├── channel.rb
│   │       └── connection.rb
│   ├── controllers/
│   │   ├── api/
│   │   │   ├── v1/
│   │   │   │   ├── leagues_controller.rb
│   │   │   │   ├── matches_controller.rb
│   │   │   │   ├── players_controller.rb
│   │   │   │   ├── teams_controller.rb
│   │   │   │   └── users/
│   │   │   │       └── devise_controller.rb
│   │   │   └── api_controller.rb
│   │   ├── application_controller.rb
│   │   └── graphql_controller.rb
│   ├── graphql/
│   │   ├── mutations/
│   │   │   ├── base_mutation.rb
│   │   │   ├── create_league.rb
│   │   │   ├── create_match.rb
│   │   │   ├── create_player.rb
│   │   │   ├── create_team.rb
│   │   │   ├── delete_league.rb
│   │   │   ├── delete_match.rb
│   │   │   ├── delete_player.rb
│   │   │   ├── delete_team.rb
│   │   │   ├── update_league.rb
│   │   │   ├── update_match.rb
│   │   │   ├── update_player.rb
│   │   │   └── update_team.rb
│   │   ├── resolvers/
│   │   │   └── base_resolver.rb
│   │   ├── types/
│   │   │   ├── base_argument.rb
│   │   │   ├── base_connection.rb
│   │   │   ├── base_edge.rb
│   │   │   ├── base_enum.rb
│   │   │   ├── base_field.rb
│   │   │   ├── base_input_object.rb
│   │   │   ├── base_interface.rb
│   │   │   ├── base_object.rb
│   │   │   ├── base_scalar.rb
│   │   │   ├── base_union.rb
│   │   │   ├── league_type.rb
│   │   │   ├── match_type.rb
│   │   │   ├── mutation_type.rb
│   │   │   ├── node_type.rb
│   │   │   ├── player_type.rb
│   │   │   ├── query_type.rb
│   │   │   └── team_type.rb
│   │   └── my_api_schema.rb
│   ├── jobs/
│   │   └── application_job.rb
│   ├── mailers/
│   │   └── application_mailer.rb
│   ├── models/
│   │   ├── concerns/
│   │   │   └── .keep
│   │   ├── application_record.rb
│   │   ├── league.rb
│   │   ├── match.rb
│   │   ├── player.rb
│   │   ├── team.rb
│   │   └── user.rb
│   ├── views/
│   │   └── layouts/
│   │       ├── mailer.html.erb
│   │       └── mailer.text.erb
├── bin/
│   ├── brakeman
│   ├── docker-entrypoint
│   ├── rails
│   ├── rake
│   ├── render-build.sh
│   ├── rubocop
│   ├── setup
├── config/
│   ├── environments/
│   │   ├── development.rb
│   │   ├── production.rb
│   │   └── test.rb
│   ├── initializers/
│   ├── locales/
│   ├── routes.rb
│   ├── application.rb
│   ├── boot.rb
│   ├── cable.yml
│   ├── credentials.yml.enc
│   ├── database.yml
│   ├── environment.rb
│   ├── puma.rb
│   ├── storage.yml
├── db/
│   ├── migrate/
│   ├── schema.rb
│   └── seeds.rb
├── lib/
│   └── tasks/
│       └── .keep
├── log/
│   ├── .keep
│   ├── development.log
│   └── test.log
├── public/
│   ├── favicon.ico
│   ├── icon.png
│   └── robots.txt
├── storage/
│   └── .keep
├── test/
│   ├── channels/
│   ├── controllers/
│   ├── fixtures/
│   ├── integration/
│   ├── mailers/
│   ├── models/
│   └── test_helper.rb
├── tmp/
│   ├── cache/
│   ├── pids/
│   ├── sockets/
│   ├── storage/
│   └── .keep
├── vendor/
│   └── .keep
├── .dockerignore
├── .gitattributes
├── .gitignore
├── .rubocop.yml
├── .ruby-version
├── config.ru
├── Dockerfile
├── Gemfile
├── Gemfile.lock
├── Rakefile
├── README.md
├── render.yaml
