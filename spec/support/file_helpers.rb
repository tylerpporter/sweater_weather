module FileHelpers
  def yaml_to_json(fixture_path)
    YAML.load_file(fixture_path).to_json
  end

  def geo_response(fixture_path)
    cassette = JSON.parse(yaml_to_json(fixture_path), symbolize_names: true)
    JSON.parse(cassette[:http_interactions].first[:response][:body][:string], symbolize_names: true)
  end
end
