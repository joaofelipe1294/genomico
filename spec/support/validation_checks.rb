module ValidationChecks

  def success_check destny_path, message_key
    click_button id: "btn-save"
    expect(find(id: "success-warning").text).to eq I18n.t message_key
    expect(page).to have_current_path destny_path
  end

  def without_value attribute_name
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "#{attribute_name} não pode ficar em branco"
  end

  def duplicated_value attribute_name
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "#{attribute_name} já está em uso"
  end

  def wrong_credentials_check
    expect(page).to have_current_path root_path
    expect(find(id: "danger-warning").text).to eq I18n.t :wrong_credentials_message
  end

  def check_count css: "classe", count: 1
    expect(find_all(class: css).size).to eq count
  end

  def location_and_success_message_check message: "", path: root_path
    expect(page).to have_current_path path
    expect(find(id: 'success-warning').text).to eq message
  end

end
