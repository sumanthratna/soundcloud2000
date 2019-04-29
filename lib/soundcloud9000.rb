require_relative 'soundcloud9000/client'
require_relative 'soundcloud9000/application'

module Soundcloud9000

  def self.start
    unless client_id = ENV['SC_CLIENT_ID']
      puts "You need to set SC_CLIENT_ID to a valid client ID"
      exit 1
    end

    client = Client.new(client_id)
    application = Application.new(client)

    Signal.trap('SIGINT') do
      application.stop
    end

    application.run
  end

end
