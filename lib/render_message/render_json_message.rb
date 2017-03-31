module JSONMessageRender
  JSONMessageRenderError = Class.new(StandardError)

private

  def render_json_status_message(status, message=nil, options={})
    render json: { head: status, status: status, message: message }.merge(options), status: status
  end

end
