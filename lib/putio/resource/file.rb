module Putio
  module Resource
    class File
      VALID_KEYS = %i{ id name content_type is_mp4_available opensubtitles_hash
        icon created_at parent_id first_accessed_at size screenshot is_shared
        crc32 }.freeze

      attr_reader *VALID_KEYS

      def initialize(params = {})
        params.select! { |p|   VALID_KEYS.include?(p) }
        params.map     { |k,v| instance_variable_set("@#{k}", v) }
      end

      def directory?
        content_type == 'application/x-directory'
      end

      def shared?
        is_shared
      end

      def mp4_available?
        is_mp4_available
      end

      def created_at
        created_at = super
        Time.parse(created_at) if created_at
      end
    end
  end
end
