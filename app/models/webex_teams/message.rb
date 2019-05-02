module WebexTeams
  class Message
    WEBEX_URL='https://api.ciscospark.com/v1/messages'

    def initialize(markdown:)
      @markdown = markdown
    end

    def deliver(room_id)
      response = Net::Hippie::Client.new.post(URI.parse(WEBEX_URL),
                                              body: {roomId: room_id, markdown: @markdown},
                                              headers: {'Authorization' => "Bearer #{ENV['WEBEX_ACCESS_CODE']}"}
                                             )

      raise 'Failed to publish to WebexTeams' unless response.is_a?(Net::HTTPOK)
    end
  end
end
