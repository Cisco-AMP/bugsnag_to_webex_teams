module WebexTeams
  class Message
    WEBEX_URL='https://api.ciscospark.com/v1/messages'
    attr_accessor :bugsnag_hook

    def initialize(bugsnag_hook)
      @bugsnag_hook = bugsnag_hook
    end

    def markdown
      trigger_message = @bugsnag_hook[:trigger][:message]
      app_release_stage = @bugsnag_hook[:error][:app][:releaseStage]
      project_name = @bugsnag_hook[:project][:name]
      error_context = @bugsnag_hook[:error][:context]
      error_url = @bugsnag_hook[:error][:url]
      error_exception_class = @bugsnag_hook[:error][:exceptionClass]
      error_message = @bugsnag_hook[:error][:message]
      stacktrace_file = @bugsnag_hook[:error][:stackTrace][:file]
      stacktrace_line_number = @bugsnag_hook[:error][:stackTrace][:lineNumber]
      stacktrace_method = @bugsnag_hook[:error][:stackTrace][:method]

      <<-MESSAGE
      #{trigger_message} in #{app_release_stage} from #{project_name} in #{error_context} (details)[#{error_url}]
      #{error_exception_class}: #{error_message}
      #{stacktrace_file}:#{stacktrace_line_number} - #{stacktrace_method}
      MESSAGE
    end

    def deliver(room_id)
      response = Net::Hippie::Client.new.post(URI.parse(WEBEX_URL),
                                              body: {roomId: room_id, markdown: markdown},
                                              headers: {'Authorization' => "Bearer #{ENV['WEBEX_ACCESS_CODE']}"}
                                             )

      raise 'Failed to publish to WebexTeams' unless response.is_a?(Net::HTTPOK)
    end
  end
end
