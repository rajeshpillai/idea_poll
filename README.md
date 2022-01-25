# README

## Steps

- rails new <projectname> -db=postgresql
- rails g controller static_pages landing_page pricing privacy terms
- rails g scaffold inbox name  (also add validation in migration file, null)
- add gem gaker -> bundle add faker
- Seed data
- robocop gem  (then run bundle exec rubocop)
 -- .rubycop.yml
- run rubo cop
  - bundle exec rubocop -a (and -A)

- add gem devise
- make devise it work with turbo (data:turbo: false in views)

- Style flash messages
