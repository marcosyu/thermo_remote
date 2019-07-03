require 'rails_helper'

RSpec.describe Reading, type: :model do

  let(:thermostat){ FactoryBot.create(:thermostat) }
  let(:reading){ FactoryBot.create(:reading) }

  describe 'associations' do
    it { should belong_to(:thermostat).class_name('Thermostat') }
  end

  describe 'validations' do
    it { should validate_presence_of(:temperature) }
    it { should validate_presence_of(:tracking_number) }
    it { should validate_presence_of(:humidity) }
    it { should validate_presence_of(:battery_charge) }
  end

end
