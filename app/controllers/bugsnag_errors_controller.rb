class BugsnagErrorsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']

  def create
    logger.info "Got a webhook call from BugSnag"
    logger.debug request.body.read
    render nothing: true, status: :created
  end

end
