require_relative 'soundcloud9000/client'
require_relative 'soundcloud9000/application'

module Soundcloud9000
  def self.getVersion
    "soundcloud9000, version #{Gem.latest_spec_for('soundcloud9000').version}"
  end

  def self.start
    unless client_id = ENV['SC_CLIENT_ID']
      puts 'You need to set SC_CLIENT_ID to a valid client ID'
      exit 1
    end

    if ARGV.include?('-v') || ARGV.include?('--version')
      puts getVersion
      puts "Copyright (C) #{Time.new.year} Sumanth Ratna"
      exit 0
    end

    if ARGV.include?('-h') || ARGV.include?('--help')
      puts getVersion
      puts 'Usage:  soundcloud9000'
      puts '        soundcloud9000 -h | --help'
      puts '        soundcloud9000 -v | --version'
      puts ''
      puts 'Options:'
      puts '-h --help       show this message, then exit'
      puts '-v --version    show soundcloud9000 version, then exit'
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
