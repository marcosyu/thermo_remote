require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  let(:thermostat){ FactoryBot.create(:thermostat) }

  describe 'validations' do
    it { should validate_presence_of(:household_token) }
    it { should validate_uniqueness_of(:household_token) }
  end
end
