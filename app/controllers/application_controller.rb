require 'render_message/render_json_message'

class ApplicationController < ActionController::Base
  # Add simple rendering for messages in JSON format
  include JSONMessageRender

  # Constants
  UNKNOWN_ERROR = 'Unknown error'

  protect_from_forgery with: :exception
end
