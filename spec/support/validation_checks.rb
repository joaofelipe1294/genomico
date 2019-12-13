module ValidationChecks

  def success_check destny_path, message_key
    click_button id: "btn-save"
    expect(page).to have_current_path destny_path
    expect(find(id: "success-warning").text).to eq I18n.t message_key
  end

  def without_value attribute_name
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "#{attribute_name} não pode ficar em branco"
  end

  def duplicated_value attribute_name
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "#{attribute_name} já está em uso"
  end

end
