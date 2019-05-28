module Blinky
  class Actor
    include Interactor

    def call
      # Begin interaction
      context.out_mode = :full
      context.depth    = :shallow
      puts help
      print "#{context.out_mode} #{context.depth} > "
      while phrase = gets.chomp
        words = phrase.squeeze(' ').downcase.split(' ')
        break if words[0] == 'quit'
        case words[0]
        when 'users'
          search('Users', Blinky::User, words) if validate_words(words)
        when 'tickets'
          search('Tickets', Blinky::Ticket, words) if validate_words(words)
        when 'organizations'
          search('Organizations', Blinky::Organization, words) if validate_words(words)
        when 'summary'
          context.out_mode = :summary
          puts 'Set output to summary mode'
        when 'full'
          context.out_mode = :full
          puts 'Set output to full mode'
        when 'deep'
          context.depth = :deep
          puts 'Set output to deep mode'
        when 'shallow'
          context.depth = :shallow
          puts 'Set output to shallow mode'
        when 'help'
          puts help
        when 'stats'
          puts stats
        end
        print "#{context.out_mode} #{context.depth} > "
      end
    end

    private

    def validate_words(words)
      return true if words.size >= 3
      puts 'Insufficient criteria: Use [group] [field] [value]'
      false
    end

    # Uses the model->ClassMethod to find field->value rows
    def search(name, klass, words)
      puts "Searching #{name}"
      rows    = []
      objects = klass.search(words[1], words[2...].join(' '))
      if context.out_mode == :full
        objects.each  do |obj|
          row = klass.vertical_row(obj, context.depth)
          table = Terminal::Table.new headings: %w(Attribute Value), rows: row
          puts table
        end
      else
        objects.each {|obj| rows << klass.table_row(obj, context.out_mode, context.depth)}
        puts Terminal::Table.new headings: klass.attributes(context.out_mode), rows: rows
      end
      puts "Total rows returned: #{objects.size}"
    end

    def stats
      rows = [
          [context.users_name, context.users.size, Blinky::User.attributes(:full).join(', ')],
          [context.organizations_name, context.organizations.size, Blinky::Organization.attributes(:full).join(', ')],
          [context.tickets_name, context.tickets.size, Blinky::Ticket.attributes(:full).join(', ')]
      ]
      puts Terminal::Table.new headings: %w(Group Count Fields), rows: rows
    end

    def help
      <<EOF

Welcome to Blinky! A simple CLI for search.
You can quit by entering "quit" at the prompt.

There are 3 "groups": users, organizations and tickets.

Groups can be searched by entering a phrases like:
  users _id 5
  users name Rose Newton
  tickets priority high
  tickets _id 436bf9b0-1147-4c0a-8439-6f79833bff5b
  organizations name nutralab

There are several "status" commands shown below. 

Status examples:
  help      Display this message
  stats     Show current groups and row totals
  summary   Summarize the tabulated output horizontally
  full      Show full details vertically
  deep      Show extended details e.g. users organization
  shallow   Do not show extended details

Output Mode: #{context.out_mode}
Depth  Mode: #{context.depth}

EOF
    end
  end
end
