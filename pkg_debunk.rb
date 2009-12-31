#!/usr/bin/env ruby

# pkg_debunk.rb used to verify installed packages by FreeBSD ports
# 
# by Aleksandar Simic 31 December 2009

if ARGV.size > 1
  puts
  puts "	either supply a name of a installed port"
  puts "	or run the #{$0} without any parameters to test all the ports"
  puts
  exit
end

def verify(pkg, path)
  # puts "path is #{path}"
  contents = File.new(path, "r").collect
  # puts "grep: #{contents.grep(/@cwd/)}"
  # prefix = contents[3].grep(/@cwd\ /).to_s.gsub(/\@cwd\ /, "").chomp
  prefix = contents[3].to_s.gsub(/\@cwd\ /, "").chomp
  # puts "prefix is: #{prefix}"

  missing = []

  contents.each { |line|
    if not line.to_s =~ /^[@\+]/
      path = [prefix, line.chomp].join "/"
      #puts "path is .#{path}."
      if not File.exists?(path)
        # puts "can't find .#{path}."
        missing << path
      end
    end
  }

  if not missing.empty?
    puts "#{pkg}:"
    missing.each {|m|
      puts "  missing #{m}"
    }
  end
end 


#def debunk
def debunk(*arg)

  if not "#{ENV['PKG_DBDIR']}".empty? 
    db = "#{ENV['PKG_DBDIR']}".chomp
  else
    db = "/var/db/pkg/"
  end

  if not File.directory?(db)
    puts
    puts "can't find package database #{db} directory, exiting ..."
    puts
    exit 1
  end

  if arg.flatten.to_s.size > 0

    puts "arg not empty"

    if not File.directory?([db, arg].join)
      #if not File.directory?([db, ARGV[0]].join)
      puts "can't find package #{arg}, exiting..."
      exit 1
    end

    path = ([db, arg].join) << "/+CONTENTS"

    if not File.exists?(path)
      puts "can't find the +CONTENTS in #{path}"
    else
      verify(arg, path)
    end

  else

    puts "arg blank"
    Dir.open(db) do |dir|
      # puts "the dirs are #{dir}"
      dir.each do |pkg|
        if not pkg =~ /^\./
          # puts "#{pkg}"
          path = ([db, pkg].join) << "/+CONTENTS"

          if not File.exists?(path)
            puts "can't find the contents for .#{pkg}"
          else
            # puts "found contents #{path}"
            verify(pkg, path)

          end # File.exists?
        end # not pkg
      end # dir.each
    end # Dir.open
  end # if arg.flatten.to_s.size > 0
end # def


debunk(ARGV[0])
