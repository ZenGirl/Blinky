require 'interactor'
require 'oj'
require 'multi_json'
require 'terminal-table'
require 'awesome_print'

$LOAD_PATH << '.'

require 'Blinky/group_methods'

require 'Blinky/organization'
require 'Blinky/ticket'
require 'Blinky/user'

require 'Blinky/validator'
require 'Blinky/loader'
require 'Blinky/actor'

module Blinky

  TICKETS       = 'tickets.json'
  USERS         = 'users.json'
  ORGANIZATIONS = 'organizations.json'

  class CLI
    include Interactor::Organizer

    organize Validator, Loader, Actor
  end
end

result = Blinky::CLI.call
if result.success?
  puts 'Process complete'
else
  puts 'An error occurred:'
  puts result.error
end
