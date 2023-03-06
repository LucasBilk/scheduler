# frozen_string_literal: true

module Vacations
  class AssignService < BaseService
    attr_accessor :collaborator, :vacation_period, :verifications

    RULES = %i[
      collaborator_vacation_balance
      minimum_start_date
      vacation_overlap
      minimum_duration
    ].freeze

    def call
      fetch_collaborator
      initialize_vacation_period
      verify_rules

      persist_vacation_period if valid_vacation_period?

      response
    end

    def response
      {
        vacation_period: vacation_period,
        verifications: verifications,
        valid: valid_vacation_period?
      }
    end

    def valid_vacation_period?
      verifications.values.all?
    end

    def fetch_collaborator
      @collaborator ||= Collaborator.find(params[:collaborator_id])
    end

    def initialize_vacation_period
      @vacation_period ||= collaborator.vacation_periods.build(start_date: params[:start_date],
                                                               end_date: params[:end_date])
    end

    def verify_rules
      @verifications = RulesEngine.verify!(self)
    end

    def persist_vacation_period
      vacation_period.save!
    end
  end
end
