module FileHelpers
  def parse_fixture(fixture_path)
    JSON.parse(File.read(fixture_path), symbolize_names: true)
  end
end
