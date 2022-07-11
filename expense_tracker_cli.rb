#!/usr/bin/ruby
require 'thor'
require_relative 'expense'
require_relative 'report_printer'
require_relative 'report_exporter'

class ExpenseTrackerCLI < Thor
  attr_reader :expenses

  def initialize()
    @expenses = []
  end

  def main
    say("Welcome to the Expense Tracker Command Line interface")
    main_loop
  end

  def main_loop
    say("Please select an option:")
    say("1) Add a expense")
    say("2) Print report")
    say("3) Save report as .csv")
    say("4) Clear expenses")
    say("5) Exit")
    option = ask("Option?", limited_to: %w(1 2 3 4 5) )

    case option
    when "1"
      handle_add_expense
    when "2"
      handle_print_report
    when "3"
      handle_report_export
    when "4"
      clear_expenses
    when "5"
      exit
    end
  end

  def handle_add_expense
    type = ask("Please specify which type of expense would you like to register",
               limited_to: ["Breakfast", "Dinner", "Car Rental"])

    begin
      amount = ask("Please specify the amount of the expense")
      while(amount !~ /\d/)
        say("Please use whole numbers")
        amount = ask("Please specify the amount of the expense")
      end
    rescue
      retry
    end

    type = underscore(type).to_sym
    puts type
    expenses << Expense.new(type, amount.to_i)

    main_loop
  end

  def handle_print_report
    say("\nPrinting report\n")
    ReportPrinter.new.print_report(*expenses)
    say("\nREPORT END\n")

    main_loop
  end

  def handle_report_export
    path = ask("Please specify a path to store the report", path: true, default: 'report.csv')
    ReportExporter.new(path, expenses, '|', "\n", '\'').generate_csv

    main_loop
  end

  def clear_expenses
    @expenses = []

    main_loop
  end

  private

  def underscore(string)
    string.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
           gsub(/([a-z\d])([A-Z])/,'\1_\2').
           tr('-', '_').
           gsub(/\s/, '_').
           gsub(/__+/, '_').
          downcase
  end
end

ExpenseTrackerCLI.new.main