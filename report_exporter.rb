#!/usr/bin/ruby
require 'csv'

class ReportExporter
  attr_reader :path, :expenses, :col_separator, :row_separator, :quote_char

  def initialize(path, expenses, col_separator, row_separator, quote_char)
    @path = path
    @expenses = expenses
    @col_separator = col_separator
    @row_separator = row_separator
    @quote_char = quote_char
  end

  def generate_csv
    CSV.open(path, "wb", csv_options) do |csv|
      csv << headers
      expenses.each do |expense|
        csv << [
          humanize(expense.type),
          expense.amount,
          exceeds_amount?(expense)
        ]
      end
    end
  end

  private

  def meal_expense_total
    expenses.filter do |expense|
      %s(breakfast, dinner, car_rental).include?(expense.type)
    end.sum(&:amount)
  end

  def expense_total
    expenses.sum(&:amount)
  end

  def exceeds_amount?(expense)
    case expense.type
    when :dinner
      expense.amount > 5000
    when :breakfast
      expense.amount > 1000
    end
  end

  def headers
    ["Expense Type", "Amount", "Exceeds amount?"]
  end

  def csv_options
    {
      col_sep: col_separator,
      row_sep: row_separator,
      quote_char: quote_char
    }
  end

  def humanize(type)
    case type
    when :breakfast
      "Breakfast"
    when :dinner
      "Dinner"
    when :car_rental
      "Car Rental"
    else
      "Unknown"
    end
  end
end