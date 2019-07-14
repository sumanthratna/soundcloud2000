require_relative '../ui/table'

module Soundcloud9000
  module Views
    # this view is responsible for the bar that separates the player and track list
    class TracksTable < UI::Table
      def initialize(*args)
        super
        self.header = %w[Title User Length Likes Comments]
        self.keys   = %i[title username length likes comments]
      end
    end
  end
end
