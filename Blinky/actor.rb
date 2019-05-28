module Blinky
  class Actor
    include Interactor

    def call
      # Begin interaction
      print prompt
      context.out_mode = :full
      context.depth    = :shallow
      while phrase = gets.chomp
        words = phrase.squeeze(' ').downcase.split(' ')
        break if words[0] == 'quit'
        case words[0]
        when 'users'
          search('Users', Blinky::User, words)
        when 'tickets'
          search('Tickets', Blinky::Ticket, words)
        when 'organizations'
          search('Organizations', Blinky::Organization, words)
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
        end
        print prompt
      end
    end

    private

    # Uses the model->ClassMethod to find field->value rows
    def search(name, klass, words)
      puts "Searching #{name}"
      rows    = []
      objects = klass.search(words[1], words[2...].join(' '))
      objects.each {|obj| rows << klass.table_row(obj, context.out_mode, context.depth)}
      puts Terminal::Table.new headings: klass.attributes(context.out_mode), rows: rows
      puts "Total rows returned: #{objects.size}"
    end

    def prompt
      <<EOF


Welcome to Blinky! A simple CLI for searching Users, Tickets and Organizations
You can quit by entering "quit" (or "q") at the prompt.
Users can be searched by entering a phrases like:
  users _id 5
  users name Rose Newton
  tickets priority high
  organizations name nutralab
Hint: Use 'summary' or 'full' to change the amount of output.
EOF
    end
  end
end
