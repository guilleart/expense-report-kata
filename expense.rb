#!/usr/bin/ruby

class Expense
  attr_reader :type, :amount

  def initialize(type, amount)
    @type = type
    @amount = amount
  end

  def name
    type.to_s.split(/ |\_/).map(&:capitalize).join(" ")
  end
end