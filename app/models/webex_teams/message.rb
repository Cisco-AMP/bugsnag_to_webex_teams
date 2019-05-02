module WebexTeams
  class Message
    WEBEX_URL='https://api.ciscospark.com/v1/messages'

    def initialize(bugsnag_hook)
      @bugsnag_hook = bugsnag_hook
    end

    def to_s
      @bugsnag_hook.to_s.first(50)
    end

    def deliver(room_id)
      response = Net::Hippie::Client.new.post(URI.parse(WEBEX_URL),
                                              body: {roomId: room_id, text: to_s},
                                              headers: {'Authorization' => "Bearer #{ENV['WEBEX_ACCESS_CODE']}"}
                                             )

      raise 'Failed to publish to WebexTeams' unless response.is_a?(Net::HTTPOK)
    end
  end
end
