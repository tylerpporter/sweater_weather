module Servicable
  def get_json(resp)
    JSON.parse(resp.body, symbolize_names: true)
  end
end
