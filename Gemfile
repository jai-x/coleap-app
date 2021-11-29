# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.0.2"

gem "bootsnap", ">= 1.4.4", require: false
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.4", ">= 6.1.4.1"
gem "sqlite3", "~> 1.4"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop" # linting
  gem "solargraph" # lsp
  gem "rspec"
  gem "rspec-rails"
end

group :development do
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
