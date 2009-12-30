#!/usr/bin/env ruby

# pkg_debunk.rb used to verify installed packages by FreeBSD ports
# 
# by Aleksandar Simic 30 December 2009


if ARGV.size < 1
  puts "supply a name of a installed port"
  exit
end

# puts "package: #{ARGV[0]}"

def debunk(arg) 
  db="/var/db/pkg/"

  # puts "from the method, db: #{db}, prefix: #{$prefix}, arg: #{arg}"

  if File.directory?([db, arg].join)

    pkg = ([db, arg].join) << "/+CONTENTS"

    if File.exists?(pkg)
      contents = File.new(pkg, "r").collect
      # puts "grep: #{contents[3].grep(/@cwd/)}"
      prefix = contents[3].grep(/@cwd\ /).to_s.gsub(/\@cwd\ /, "").chomp

      missing = []

      contents.each { |line|
        if not line.to_s =~ /^[@\+]/
          path = [prefix, line.chomp].join "/"
          if not File.exists?(path)
            # puts "can't find .#{path}."
            missing << path
          end
        end
      }

      if not missing.empty?
        puts "#{arg}:"
        missing.each {|m|
          puts "  missing #{m}"
        }
      end

    else
      puts
      puts "the +CONTENTS file of #{arg} can't be read, exiting ..."
      puts
      exit 1
    end

  else
    puts
    puts "can't find #{arg} package, exiting ..."
    puts
    exit 1
  end
end # def                          

debunk(ARGV[0])
