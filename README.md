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
- Basic styles
- Connect Inbox to User
  - rails g migration add_user_id_to_inboxes user:references
  - rails db:reset
  - rails db:migrate

- Scaffold message
  - rails g scaffold message body:text inbox:references user:references

- Create messages (via inbox)

- Cleanup

- Counter cache
  - rails g migration add_messages_count_to_inboxes messages_count:integer
  
- Message Controller (refactor: @inbox.messages rather than Message.find etc)

- User can vote on messages
  - act_as_votable gem
  - rails g acts_as_votable:migration
  - rails db:migrate

- User Authorization
  - only owner can edit/destroy their inbox
  - bundle add pundit
  - rails g pundit:install  (will create policy folder)

- Friendly ID
  - bundly add friendly_id
  - rails g migration AddSlugToInboxes slug:uniq
  - rails db:migrate
  - rails console
    - Inbox.find_each(&:save)   # update existing data
    - Inbox.pluck(:slug)  # for testing

- Seed data

- Improving forms (maxlength etc)

- Gem : bundle add meta-tags
  - rails g meta_tags:install
  - add meta tags to pages (layout, controller)

- Turbo features
  - Inbox -> Add Messages directly in inbox (inline)
  - Update the message count
  - Show messages when new message is added (without refresh)
  - Add destroy (turbo)

- Fix order of messaging

- Turbo : Voting

- Turbo : Flash messages

- Refactor turbo flash

- Add Theme Color to Inboxes



