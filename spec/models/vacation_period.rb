# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VacationPeriod, type: :model do
  describe 'Vacation Period' do
    subject { create(:vacation_period) }

    context 'attributes validations' do
      it { should validate_presence_of(:start_date) }
      it { should validate_presence_of(:end_date) }
      it { should belong_to(:collaborator) }
    end
  end
end
