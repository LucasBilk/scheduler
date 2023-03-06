# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  describe 'Collaborator' do
    subject { create(:collaborator_with_vacation) }

    context 'attributes validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:role) }
      it { should validate_presence_of(:contract_date) }
      it { should have_many(:vacation_periods) }
    end
  end
end
