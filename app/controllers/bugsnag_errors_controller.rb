class BugsnagErrorsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']

  def create
    notification = BugsnagNotifications::Notification.new(params)
    message = WebexTeams::Message.new(notification.markdown)
    logger.debug "Sending message: #{notification.markdown} to WebEx to room #{params[:webex_room_id]}"
    message.deliver(params[:webex_room_id])
    render nothing: true, status: :created
  end

end
