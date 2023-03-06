# frozen_string_literal: true

class Collaborator < ApplicationRecord
  has_many :vacation_periods

  validates_presence_of :name
  validates_presence_of :role
  validates_presence_of :contract_date
end
