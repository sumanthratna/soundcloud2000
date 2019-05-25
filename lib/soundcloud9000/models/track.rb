require_relative 'user'
require_relative '../application'

module Soundcloud9000
  module Models
    # stores information for each track that hits the player
    class Track
      def initialize(hash)
        Application.logger.debug(hash)
        @hash = hash
      end

      def id
        @hash['id']
      end

      def title
        @hash['title']
      end

      def url
        @hash['permalink_url']
      end

      def user
        @user ||= User.new(@hash['user'])
      end

      def username
        user.username
      end

      def duration
        @hash['duration']
      end

      def length
        TimeHelper.duration(duration)
      end

      def plays
        @hash['playback_count']
      end

      def likes
        @hash['favoritings_count']
      end

      def comments
        @hash['comment_count']
      end

      def stream_url
        @hash['stream_url']
      end
    end
  end
end
