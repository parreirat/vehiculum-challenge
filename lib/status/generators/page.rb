require 'thor/group'
module Status
  module Generators
    class Page < Thor::Group
      include Thor::Actions
      SEPARATOR = "*" * 80

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      argument :name, type: :string
      argument :page_url, type: :string

      def copy_page_template

        @new_file = "lib/status/pages/#{name}.rb"
        @class_name = name.capitalize.to_s
        @constant_name = "Status::Pages::#{@class_name}"
        @provider_name = name.downcase.to_s

        template("page.rb", @new_file) do |body|
          new_body = body
          new_body.sub!("__class_name__", @class_name)
          new_body.sub!("__page_url__", page_url)
          new_body.sub!("__provider_name__", @provider_name)
          new_body
        end

      end

      def make_user_implement_template!
        implemented = false
        loop.with_index do |_, index|
          break if implemented

          if index.zero?
            # @parreirat TODO - Would be nice to have "set_color_red" and such
            # helpers for colored output, just emit starting escape characters.
            # Maybe something akin to this?
            #
            # def with_red
            #   return unless block_given?
            #   print "\e[1;31m"
            #   begin yield ensure print "\e[0m" end
            # end
            puts "\n" + SEPARATOR.yellow
            print "Created file lib/status/pages/#{name}.rb \nYou ".yellow
            print "need to implement #{@constant_name}\#is_page_up?\n".yellow
            puts SEPARATOR.yellow + "\n"
          end

          puts "\n" + SEPARATOR.yellow
          puts "Your implementation didn't work. Retry edit? [Y]es [N]o:".yellow if implemented
          print "Would you like to open vim on the method? [Y]es [N]o:".yellow unless implemented
          puts "\n" + SEPARATOR.yellow + "\n"
          input = STDIN.gets.chomp
          if input.match(/Y/i)
            system("vim #{@new_file} +44")
            # @parreirat NOTE - We cannot unrequire in ruby. In case our file
            # already exists and is being overwriten, @constant_name won't get
            # reloaded.
            # Hacky way: remove our require from $LOADED_FEATURES, so ruby
            # thinks it's not yet loaded and so goes ahead and reloads it. :)
            $LOADED_FEATURES.reject! { |file| file =~ /#{@new_file}/ }
            require "status/pages/#{@provider_name}"
            klass = Kernel.const_get(@constant_name)
            if defined?(klass.new.is_page_up?)
              implemented = true
              puts "\n" + SEPARATOR.green
              print "Let's see if your implementation works, calling status".green
              print " pull --webpages #{@provider_name} in 3..2..1..".green
              puts "\n" + SEPARATOR.green + "\n"
              begin
                successful = system ("status pull --webpages #{@provider_name}")
                if successful
                  puts "\n" + SEPARATOR.green
                  print "Congratulations, it seems to work! ┬─┬⃰͡ (ᵔᵕᵔ͜ )".green
                  puts "\n" + SEPARATOR.green + "\n"
                  break
                end
              rescue => e
                # @parreirat TODO - Didn't figure out how to rescue exception
                # thrown by a system call. Oh well!
                puts "\n" + SEPARATOR.red
                print "Your implementation blew up!!!".red
                print "(╯°□°）╯︵ ┻━┻ (╯°□°）╯︵ ┻━┻ (╯°□°）╯︵ ┻━┻".red
                puts "\n" + SEPARATOR.red + "\n"
              end
            else
              puts "\n" + SEPARATOR.red
              print "You did not implement #{@constant_name}\#is_page_up?'\n".red
              print "in lib/status/pages/#{name}.rb! ( ಠ ʖ̯ ಠ)".red
              puts "\n" + SEPARATOR.red + "\n"
            end
          else
            puts SEPARATOR.yellow
            print "Please implement #{@constant_name}\#is_page_up?' in\n".yellow
            print "lib/status/pages/#{name}.rb! ( ఠ ͟ʖ ఠ)".yellow
            puts "\n" + SEPARATOR.yellow + "\n"
            break
          end
        end

      end

    end
  end
end