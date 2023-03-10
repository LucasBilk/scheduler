# frozen_string_literal: true

class VacationPeriod < ApplicationRecord
  belongs_to :collaborator

  validates_presence_of :start_date
  validates_presence_of :end_date

  def period_in_days
    (end_date.to_datetime - start_date.to_datetime).to_i
  end
end
