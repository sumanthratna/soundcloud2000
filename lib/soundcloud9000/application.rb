require 'logger'

require_relative 'ui/canvas'
require_relative 'ui/input'
require_relative 'ui/rect'

require_relative 'controllers/track_controller'
require_relative 'controllers/player_controller'

require_relative 'models/track_collection'
require_relative 'models/player'

require_relative 'views/tracks_table'
require_relative 'views/splash'

module Soundcloud9000
  class Application
    include Controllers
    include Models
    include Views

    def initialize(client)
      $stderr.reopen('debug.log', 'w')
      @canvas = UI::Canvas.new

      @splash_controller = Controller.new(
        Splash.new(
          UI::Rect.new(0, 0, Curses.cols, Curses.lines)
        )
      )

      @track_controller = TrackController.new(
        TracksTable.new(
          UI::Rect.new(0, 5, Curses.cols, Curses.lines - 5)
        ), client
      )

      @track_controller.bind_to(TrackCollection.new(client))

      @player_controller = PlayerController.new(
        PlayerView.new(
          UI::Rect.new(0, 0, Curses.cols, 5)
        ), client
      )

      @track_controller.events.on(:select) do |track|
        @player_controller.play(track)
      end

      @player_controller.events.on(:complete) do
        @track_controller.next_track
      end
    end

    def main
      loop do
        if @workaround_was_called_once_already
          handle UI::Input.get(-1)
        else
          @workaround_was_called_once_already = true
          handle UI::Input.get(0)
          @track_controller.load
          @track_controller.render
        end

        break if stop?
      end
    ensure
      @canvas.close
    end

    def run
      @splash_controller.render
      main
    end

    # TODO: look at active controller and send key to active controller instead
    def handle(key)
      case key
      when :left, :right, :space, :one, :two, :three, :four, :five, :six, :seven, :eight, :nine
        @player_controller.events.trigger(:key, key)
      when :down, :up, :enter, :u, :f, :s, :j, :k, :m, :h, :o
        @track_controller.events.trigger(:key, key)
      end
    end

    def stop
      @stop = true
    end

    def stop?
      @stop == true
    end

    def self.logger
      @logger ||= Logger.new('debug.log')
    end

    def self.get_version
      "soundcloud9000, version #{Gem.latest_spec_for('soundcloud9000').version}"
    end

    def self.get_help
      %(
      #{get_version}
      Usage:  soundcloud9000
              soundcloud9000 -h | --help
              soundcloud9000 -v | --version

      Options:
      -h --help       show this message, then exit
      -v --version    show soundcloud9000 version, then exit
    )
    end
  end
end
