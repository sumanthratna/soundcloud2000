require_relative 'controller'
require_relative '../time_helper'
require_relative '../ui/table'
require_relative '../ui/input'
require_relative '../models/track_collection'
require_relative '../models/user'

module Soundcloud9000
  module Controllers
    # Handles the navigation thru the current track list
    class TrackController < Controller
      def initialize(view, client)
        super(view)

        @client = client

        events.on(:key) do |key|
          case key
          when :enter
            @view.select
            events.trigger(:select, current_track)
          when :up, :k
            @view.up
          when :down, :j
            @view.down
            @tracks.load_more if @view.bottom?
          when :u
            user = fetch_user_with_message('Change to soundcloud user: ')
            unless user.nil?
              @client.current_user = user
              @tracks.collection_to_load = :user
              @tracks.clear_and_replace
            end
          when :f
            @client.current_user = fetch_user_with_message('Change to SoundCloud user\'s favourites: ') if @client.current_user.nil?
            unless @client.current_user.nil?
              @tracks.collection_to_load = :favorites
              @tracks.clear_and_replace
            end
          when :s
            @view.clear
            @client.current_user = fetch_user_with_message('Change to SoundCloud user: ') if @client.current_user.nil?
            unless @client.current_user.nil?
              set = UI::Input.getstr('Change to SoundCloud playlist: ')
              set_request = @client.resolve(@client.current_user.permalink + '/sets/' + set)
              if set_request.nil?
                UI::Input.error("No such set/playlist '#{set}' for #{@client.current_user.username}")
                @client.current_user = nil
              else
                @tracks.playlist = Models::Playlist.new(set_request)
                @tracks.collection_to_load = :playlist
                @tracks.clear_and_replace
              end
            end
          # when :im grown up, im gonna go to brown and be smarter than u, sumanth <333 (Rahel Selemon, April 29, 2019)
          when :m
            @tracks.shuffle = !@tracks.shuffle
            UI::Input.message("Shuffle #{@tracks.shuffle ? 'enabled' : 'disabled'}.")
          when :h
            @tracks.help = !@tracks.help
            if @tracks.help
              height = 40
              width  = 80
              top    = (Curses.lines - height) / 2
              left   = (Curses.cols - width) / 2
              win    = Curses::Window.new(height, width, top, left)
              win.attrset(Curses.color_pair(4) | Curses::A_REVERSE | Curses::A_BOLD)
              win.setpos(2, 3)
              help = Application.get_help
              win.addstr(help)
              win.setpos(help.lines.count, 0)
              win.addstr('-' * width)
              win.setpos(help.lines.count + 1, 3)
              shortcuts = %(
            Shortcuts:
            [enter]           play selected track from beginning
            [down]/j          select track below currently selected track
            [up]/k            select track above currently selected track
            [space]           play or pause the current track
            [right]/[left]    move backward or forward in current track
            1                 jump to the time at 1/10 of the current track
            2                 jump to the time at 2/10 of the current track
            3                 jump to the time at 3/10 of the current track
            4                 jump to the time at 4/10 of the current track
            5                 jump to the time at 5/10 of the current track
            6                 jump to the time at 6/10 of the current track
            7                 jump to the time at 7/10 of the current track
            8                 jump to the time at 8/10 of the current track
            9                 jump to the time at 9/10 of the current track
            u                 play tracks of different users
            f                 play favorites from a user
            s                 play sets/playlists from a user
            m                 play songs in random order
            h                 toggle this help screen
              )
              win.addstr(shortcuts)
              win.box('|', '-')
              win.refresh
              win.getch
              win.close
            else
              @tracks.clear_and_replace
            end
          end
        end
      end

      def fetch_user_with_message(message_to_display)
        permalink = UI::Input.getstr(message_to_display)
        user_hash = @client.resolve(permalink)
        if user_hash
          Models::User.new(user_hash)
        else
          UI::Input.error("No such user '#{permalink}'. Use u to try again.")
          nil
        end
      end

      def current_track
        @tracks[@view.current]
      end

      def bind_to(tracks)
        @tracks = tracks
        @view.bind_to(tracks)
      end

      def load
        @tracks.load
      end

      def next_track
        if @tracks.shuffle
          @view.random
        else
          @view.down
        end
        @view.select
        events.trigger(:select, current_track)
      end
    end
  end
end
