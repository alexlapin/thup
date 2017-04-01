require 'render_message/render_json_message'

class ApplicationController < ActionController::Base #ActionController::API
  # Add simple rendering for messages in JSON format
  include JSONMessageRender
  protect_from_forgery with: :exception
end
