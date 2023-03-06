# frozen_string_literal: true

class CreateVacationPeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :vacation_periods do |t|
      t.timestamp :start_date
      t.timestamp :end_date
      t.references :collaborator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
