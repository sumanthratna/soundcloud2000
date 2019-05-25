require_relative 'soundcloud9000/client'
require_relative 'soundcloud9000/application'

module Soundcloud9000
  def self.start
    unless client_id = ENV['SC_CLIENT_ID']
      puts 'You need to set SC_CLIENT_ID to a valid client ID'
      exit 1
    end

    if ARGV.include?('-v') || ARGV.include?('--version')
      puts Application.get_version
      puts "Copyright (C) #{Time.new.year} Sumanth Ratna"
      exit 0
    end

    if ARGV.include?('-h') || ARGV.include?('--help')
      puts Application.get_help
      exit 0
    end

    client = Client.new(client_id)
    application = Application.new(client)

    Signal.trap('SIGINT') do
      application.stop
    end

    application.run
  end
end
