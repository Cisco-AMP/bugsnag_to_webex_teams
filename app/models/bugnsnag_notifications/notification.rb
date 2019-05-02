module BugsnagNotifications
  class Notification
    attr_accessor :data

    def initialize(data = {})
      @data = data
    end

    def markdown
      trigger_message = @data[:trigger][:message]
      app_release_stage = @data[:error][:app][:releaseStage]
      project_name = @data[:project][:name]
      error_context = @data[:error][:context]
      error_url = @data[:error][:url]
      error_exception_class = @data[:error][:exceptionClass]
      error_message = @data[:error][:message]
      stacktrace = @data[:error][:stackTrace][0]
      stacktrace_file = stacktrace[:file]
      stacktrace_line_number = stacktrace[:lineNumber]
      stacktrace_method = stacktrace[:method]

      <<-MARKDOWN
#{trigger_message} in __#{app_release_stage}__ from __#{project_name}__ in __#{error_context}__ ([details](#{error_url}))
```
#{error_exception_class}:#{error_message}
#{stacktrace_file}:#{stacktrace_line_number} - #{stacktrace_method}
```
MARKDOWN
    end

  end
end
