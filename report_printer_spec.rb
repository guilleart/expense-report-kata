#!/usr/bin/ruby
require 'rspec'
require_relative 'report_printer'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe ReportPrinter do
  before{subject = ReportPrinter.new}

  # No expenses
  it "print report with no expenses, prints a timestamp" do
    expenses = []
    expect do
      subject.print_report(*expenses)
    end.to output(/Expenses: #{Time.now}/).to_stdout
  end
  it "print report with no expenses, prints meal expenses in 0" do
    expenses = []
    expect do
      subject.print_report(*expenses)
    end.to output(/Meal Expenses: 0/).to_stdout
  end
  it "print report with no expenses, prints total expenses in 0" do
    expenses = []
    expect do
      subject.print_report(*expenses)
    end.to output(/Total Expenses: 0/).to_stdout
  end

  #Only breakfast
  it "print report with breakfast, prints a timestamp" do
    expenses = [ Expense.new(:breakfast, 2) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Expenses: #{Time.now}/).to_stdout
  end
  it "print report with breakfast, prints 25 for breakfast" do
    expenses = [ Expense.new(:breakfast, 25) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Breakfast.*25/).to_stdout
  end
  it "print report with breakfast, does not print over expense marker (X) for less than 1000 in breakfast" do
    expenses = [ Expense.new(:breakfast, 999) ]
    expect do
      subject.print_report(*expenses)
    end.not_to output(/Breakfast.*X/).to_stdout
  end
  it "print report with breakfast, prints over expense marker (X) for over 1000 in breakfast" do
    expenses = [ Expense.new(:breakfast, 1001) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Breakfast.*X/).to_stdout
  end
  it "print report with breakfast, prints the correct total 25 for meals" do
    expenses = [ Expense.new(:breakfast, 25) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Meal Expenses: 25/).to_stdout
  end
  it "print report with breakfast, prints the correct final total 32" do
    expneses = [ Expense.new(:breakfast, 32) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Total Expenses: 32/).to_stdout
  end

  #Only dinner
  it "print report with dinner, prints a timestamp" do
    expenses = [ Expense.new(:dinner, 2) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Expenses: #{Time.now}/).to_stdout
  end
  it "print report with breakfast, prints 14 for dinner" do
    expenses = [ Expense.new(:dinner, 14) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Dinner.*14/).to_stdout
  end
  it "print report with dinner, does not print over expense marker (X) for less than 5000 in dinner" do
    expenses = [ Expense.new(:dinner, 4991) ]
    expect do
      subject.print_report(*expenses)
    end.not_to output(/Dinner.*X/).to_stdout
  end
  it "print report with breakfast, prints over expense marker (X) for over 5000 in dinner" do
    expenses = [ Expense.new(:dinner, 5001) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Dinner.*X/).to_stdout
  end
  it "print report with dinner, prints the correct total 34 for meals" do
    expenses = [ Expense.new(:dinner, 34) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Meal Expenses: 34/).to_stdout
  end
  it "print report with dinner, prints the correct final total 192" do
    expenses = [ Expense.new(:dinner, 192) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Total Expenses: 192/).to_stdout
  end

  #Only car rental
  it "print report with car rental, prints a timestamp" do
    expenses = [ Expense.new(:car_rental, 2) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Expenses: #{Time.now}/).to_stdout
  end
  it "print report with car rental, prints 253 for car rental" do
    expenses = [ Expense.new(:car_rental, 253) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Car Rental.*253/).to_stdout
  end
  it "print report with car rental, prints the correct total 0 for meals" do
    expenses = [ Expense.new(:car_rental, 12) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Meal Expenses: 0/).to_stdout
  end
  it "print report with car rental, prints the correct final total 21" do
    expenses = [ Expense.new(:car_rental, 21) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Total Expenses: 21/).to_stdout
  end

  # Breakfast and car rental
  it "print report with breakfast and car rental, prints timestamp" do
    expenses = [ Expense.new(:breakfast, 10), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Expenses: #{Time.now}/).to_stdout
  end
  it "print report with breakfast and car rental, prints 100 for breakfast" do
    expenses = [ Expense.new(:breakfast, 100), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Breakfast.*1/).to_stdout
  end
  it "print report with breakfast and car rental, does not print over expense marker (X) for less than 1000 in breakfast" do
    expenses = [ Expense.new(:breakfast, 999), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.not_to output(/Breakfast.*X/).to_stdout
  end
  it "print report with breakfast and car rental, prints over expense marker (X) for over 1000 in breakfast" do
    expenses = [ Expense.new(:breakfast, 12300), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Breakfast.*X/).to_stdout
  end
  it "print report with breakfast and car rental, prints 1234 for car rental" do
    expenses = [ Expense.new(:breakfast, 100), Expense.new(:car_rental, 1234) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Car Rental.*12/).to_stdout
  end
  it "print report with breakfast and car rental, prints correct total 5 for meals" do
    expenses = [ Expense.new(:breakfast, 5), Expense.new(:car_rental, 200) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Meal Expenses: 5/).to_stdout
  end
  it "print report with breakfast and car rental, prints correct final total 221" do
    expenses = [ Expense.new(:breakfast, 222), Expense.new(:car_rental, -1) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Total Expenses: 221/).to_stdout
  end

  # Dinner and car rental
  it "print report with dinner and car rental, prints timestamp" do
    expenses = [ Expense.new(:dinner, 20), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Expenses: #{Time.now}/).to_stdout
  end
  it "print report with dinner and car rental, prints 110 for dinner" do
    expenses = [ Expense.new(:dinner, 110), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Dinner.*110/).to_stdout
  end
  it "print report with dinner and car rental, does not print over expense marker (X) for less than 5000 in dinner" do
    expenses = [ Expense.new(:dinner, 4999), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.not_to output(/Dinner.*X/).to_stdout
  end
  it "print report with dinner and car rental, prints over expense marker (X) for over 5000 in dinner" do
    expenses = [ Expense.new(:dinner, 6110), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Dinner.*X/).to_stdout
  end
  it "print report with dinner and car rental, prints 2134 for car rental" do
    expenses = [ Expense.new(:dinner, 120), Expense.new(:car_rental, 2134) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Car Rental.*2134/).to_stdout
  end
  it "print report with dinner and car rental, prints correct total 15 for meals" do
    expenses = [ Expense.new(:dinner, 15), Expense.new(:car_rental, 200) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Meal Expenses: 15/).to_stdout
  end
  it "print report with dinner and car rental, prints correct final total 2763" do
    expenses = [ Expense.new(:dinner, 451), Expense.new(:car_rental, 2312) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Total Expenses: 2763/).to_stdout
  end

  # Breakfast and dinner
  it "print report with breakfast and dinner, prints timestamp" do
    expenses = [ Expense.new(:breakfast, 20), Expense.new(:dinner, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Expenses: #{Time.now}/).to_stdout
  end
  it "print report with breakfast and dinner, prints 20 for breakfast" do
    expenses = [ Expense.new(:breakfast, 20), Expense.new(:dinner, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Breakfast.*20/).to_stdout
  end
  it "print report with breakfast and dinner, does not print over expense marker (X) for less than 1000 in breakfast" do
    expenses = [ Expense.new(:breakfast, 999), Expense.new(:car_rental, 231) ]
    expect do
      subject.print_report(*expenses)
    end.not_to output(/Breakfast.*X/).to_stdout
  end
  it "print report with breakfast and dinner, prints over expense marker (X) for over 1000 in breakfast" do
    expenses = [ Expense.new(:breakfast, 1110), Expense.new(:dinner, 231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Breakfast.*X/).to_stdout
  end
  it "print report with breakfast and dinner, prints 789 for dinner" do
    expenses = [ Expense.new(:breakfast, 49), Expense.new(:dinner, 789) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Dinner.*789/).to_stdout
  end
  it "print report with breakfast and dinner, does not print over expense marker (X) for less than 5000 in dinner" do
    expenses = [ Expense.new(:breakfast, 531), Expense.new(:dinner, 4999) ]
    expect do
      subject.print_report(*expenses)
    end.not_to output(/Dinner.*X/).to_stdout
  end
  it "print report with breakfast and dinner, prints over expense marker (X) for over 5000 in dinner" do
    expenses = [ Expense.new(:breakfast, 1110), Expense.new(:dinner, 5231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Breakfast.*X/).to_stdout
  end
  it "print report with breakfast and dinner, prints correct total 438 for meals" do
    expenses = [ Expense.new(:breakfast, 40), Expense.new(:dinner, 398) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Meal Expenses: 438/).to_stdout
  end
  it "print report with breakfast and dinner, prints correct final total 5560" do
    expenses = [ Expense.new(:breakfast, 999), Expense.new(:dinner, 4561) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Total Expenses: 5560/).to_stdout
  end

  # Breakfast, dinner and car rental
  it "print report with breakfast, dinner and car rental. Prints timestamp" do
    expenses = [ Expense.new(:breakfast, 222), Expense.new(:dinner, 25), Expense.new(:car_rental, 1231) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Expenses: #{Time.now}/).to_stdout
  end
  it "print report with breakfast, dinner and car rental. prints 30 for breakfast" do
    expenses = [ Expense.new(:breakfast, 30), Expense.new(:dinner, 138), Expense.new(:car_rental, 138) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Breakfast.*30/).to_stdout
  end
  it "print report with breakfast, dinner and car rental. prints 1234 for car rental" do
    expenses = [ Expense.new(:breakfast, 234), Expense.new(:dinner, 220), Expense.new(:car_rental, 1234) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Car Rental.*1234/).to_stdout
  end
  it "print report with breakfast, dinner and car rental. prints correct total 110 for meals" do
    expenses = [ Expense.new(:breakfast, 76), Expense.new(:dinner, 34), Expense.new(:car_rental, 578) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Meal Expenses: 110/).to_stdout
  end
  it "print report with breakfast, dinner and car rental. prints correct final total 221" do
    expenses = [ Expense.new(:breakfast, 86), Expense.new(:dinner, 34), Expense.new(:car_rental, 78) ]
    expect do
      subject.print_report(*expenses)
    end.to output(/Total Expenses: 198/).to_stdout
  end
end
