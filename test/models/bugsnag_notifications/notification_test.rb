require 'test_helper'
require 'bugnsnag_notifications/notification'

class NotificationTest < ActiveSupport::TestCase

  test "markdown conversion has the highlights info" do
    notification = BugsnagNotifications::Notification.new(
      trigger: {
        message: 'Error'
      },
      error: {
        app: {
          releaseStage: 'Development'
        },
        context: 'gaga#index',
        url: 'https://some/url',
        exceptionClass: 'RuntimeError',
        message: 'Not Found',
        stackTrace: [
          {
            file: '/app/gaga.rb',
            lineNumber: 21,
            method: 'index'
          }
        ]
      },
      project: {
        name: 'Gaga'
      }
    )

    expected = <<-MARKDOWN
Error in __Development__ from __Gaga__ in __gaga#index__ ([details](https://some/url))
```
RuntimeError:Not Found
/app/gaga.rb:21 - index
```
MARKDOWN
    assert_equal(expected, notification.markdown)
  end

end
