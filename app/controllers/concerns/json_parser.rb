module JsonParser
  extend ActiveSupport::Concern

  def parse_list key, model, parameters
    param = parameters[key]
    if param
      if param == ""
        parameters[key] = []
      else
        json = JSON.parse param
        objects = json.map { |object_json| model.new(object_json)}
        parameters[key] = objects
      end
    end
    parameters
  end

end
