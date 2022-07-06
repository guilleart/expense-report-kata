#!/usr/bin/ruby
require 'rspec'
require_relative 'report_cli'

RSpec.describe CLI do
  context "initial" do
    it "works" do
      expect do
        Expense.new(:foo, 1)
      end.not_to raise_error
    end
  end

  context "#report" do
    context "with no expenses" do
      let(:expenses) { [] }
      it "prints a timestamp" do
        expect do
          print_report(*expenses)
        end.to output(/Expenses: #{Time.now}/).to_stdout
      end
      it "prints meal expenses in 0" do
        expect do
          print_report(*expenses)
        end.to output(/Meal Expenses: 0/).to_stdout
      end
      it "prints total expenses in 0" do
        expect do
          print_report(*expenses)
        end.to output(/Total Expenses: 0/).to_stdout
      end
    end

    context "with breakfast" do
      let(:expenses) { [ Expense.new(:breakfast, 2) ] }
      it "prints a timestamp" do
        expect do
          print_report(*expenses)
        end.to output(/Expenses: #{Time.now}/).to_stdout
      end

      it "prints the correct total for meals" do
        expect do
          print_report(*expenses)
        end.to output(/Meal Expenses: 2/).to_stdout
      end

      it "prints the correct total" do
        expect do
          print_report(*expenses)
        end.to output(/Total Expenses: 2/).to_stdout
      end

      it "prints the Breakfast expense" do
        expect do
          print_report(*expenses)
        end.to output(/Breakfast/)
      end
    end

    context "with dinner" do
      let(:expenses) { [ Expense.new(:dinner, 2) ] }
      it "prints a timestamp" do
        expect do
          print_report(*expenses)
        end.to output(/Expenses: #{Time.now}/).to_stdout
      end

      it "prints the correct total for meals" do
        expect do
          print_report(*expenses)
        end.to output(/Meal Expenses: 2/).to_stdout
      end

      it "prints the correct total" do
        expect do
          print_report(*expenses)
        end.to output(/Total Expenses: 2/).to_stdout
      end
    end

    context "with car rental" do
      let(:expenses) { [ Expense.new(:car_rental, 2) ] }
      it "prints a timestamp" do
        expect do
          print_report(*expenses)
        end.to output(/Expenses: #{Time.now}/).to_stdout
      end

      it "prints the correct total for meals" do
        expect do
          print_report(*expenses)
        end.to output(/Meal Expenses: 0/).to_stdout
      end

      it "prints the correct total" do
        expect do
          print_report(*expenses)
        end.to output(/Total Expenses: 2/).to_stdout
      end
    end
  end

end