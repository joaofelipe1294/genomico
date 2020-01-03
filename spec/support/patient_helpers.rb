module PatientHelpers

  def navigate_to_edit_patient
    generate_hospitals
    generate_patients
    patient = create(:patient, name: 'Momir Vig', hospital: Hospital.HPP)
    imunofeno_user_do_login
    find_patient_by_name_and_go_to_edit patient
  end

  def find_patient_by_name_and_go_to_edit patient
    click_link id: 'patient-dropdown'
    click_link id: 'patients'
    fill_in id: 'patient-name-search', with: patient.name
    click_button id: 'btn-search-by-name'
    click_link class: 'patient-info', match: :first
    click_link class: 'edit-patient'
  end

  def generate_patients
    create(:patient, hospital: Hospital.HPP)
    create(:patient, hospital: Hospital.HPP)
    create(:patient, hospital: Hospital.HPP)
  end

  def fill_patient_fields
  	fill_in(:patient_name, with: @patient.name) if @patient.name
  	fill_in(:patient_mother_name, with: @patient.mother_name) if @patient.mother_name
  	fill_in(:patient_birth_date, with: @patient.birth_date) if @patient.birth_date
  	fill_in(:patient_medical_record, with: @patient.medical_record) if @patient.medical_record
  	select(@patient.hospital.name, from: "patient[hospital_id]").select_option if @patient.hospital
  	fill_in "patient[observations]", with: @patient.observations if @patient.observations
  end

  private

    def generate_hospitals
      Hospital.create([
        {name: 'Orzhov'},
        {name: 'Rakdos'},
        {name: 'Selesnya'},
        {name: 'Azorius'},
        {name: 'Hospital Pequeno Príncipe'}
      ])
    end

end
