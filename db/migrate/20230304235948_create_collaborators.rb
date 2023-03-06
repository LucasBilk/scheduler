# frozen_string_literal: true

class CreateCollaborators < ActiveRecord::Migration[6.1]
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :role
      t.timestamp :contract_date

      t.timestamps
    end
  end
end
