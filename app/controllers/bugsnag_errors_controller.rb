class BugsnagErrorsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']

  def create
    message = WebexTeams::Message.new(JSON.parse(request.body.read).with_indifferent_access)
    logger.debug message.bugsnag_hook
    message.deliver(params[:webex_room_id])
    render nothing: true, status: :created
  end

end
