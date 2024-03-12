gem install bundler
gem install rails
touch Gemfile
bundle install

rails db:migrate

RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev,.preview.app.github.dev,.app.github.dev"