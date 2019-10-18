module JsonParser
  # extend ActiveSupport::Concern

  def parse_list key, model, parameters
    param = parameters[key]
    if param
      json = JSON.parse param
      objects = json.map { |object_json| model.new(object_json)}
      parameters[key] = objects
    end
    parameters
  end

end
