# frozen_string_literal: true

class RulesEngine
  attr_accessor :entity, :rules, :verifications

  def initialize(entity)
    @entity = entity
    @rules = entity.class::RULES
    @verifications = {}
  end

  def self.verify!(entity)
    new(entity).verify
  end

  def verify
    rules.map { |rule_name| verify_rule(rule_name) }

    verifications
  end

  def verify_rule(rule_name)
    rule = rule_klass(rule_name)

    verifications[rule_name] = rule.verify(entity)
  end

  def rule_klass(rule_name)
    "#{entity.class.to_s.deconstantize}::Rules::#{rule_name.to_s.classify}".constantize
  end
end
