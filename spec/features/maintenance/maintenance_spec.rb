require 'rails_helper'
require 'rake'

RSpec.feature "Maintenance::Maintenances", type: :feature do
  include UserLogin

  describe "Maintenance mode" do

    before :each do
      Rails.application.load_seed
      Rails.application.load_tasks
      Rails.cache.clear
      biomol_user_do_login
    end

    context "when maintenance mode is of" do

      it "is expected to navigate without redirect to maintenance page" do
        expect(page).to have_current_path home_path
      end

    end

    context "when maintenance is on" do

      it "is expected to be redirected to maintenance page" do
        Rake::Task['maintenance:start'].invoke
        visit current_path
        expect(page).to have_current_path maintenance_path
      end

    end

    context "when maintenance is turned of " do

      it "is expected to be redirected to root path" do
        Rake::Task['maintenance:start'].invoke
        visit current_path
        Rake::Task['maintenance:stop'].invoke
        visit current_path
        expect(page).to have_current_path home_path
      end

    end

  end

end
