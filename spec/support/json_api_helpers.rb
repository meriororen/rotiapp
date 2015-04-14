module JsonApiHelpers
  private
  def json_response
    @json_response ||= JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include JsonApiHelpers, type: :controller
end
