require 'capybara/cuprite'
Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(
    app,
    js_errors:       true,
    window_size:     [1200, 900],
  )
end

Capybara.javascript_driver = :cuprite
