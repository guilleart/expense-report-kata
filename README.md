# ExpenseReport Kata
Taken from: https://github.com/christianhujer/expensereport

# ExpenseReport
This is an example of a piece of legacy code with lots of code smells.
The goal is to support the following new feature as best as you can:
* Add Lunch with an expense limit of 2000.

## Steps
1. Cleanup specs report_printer_spec.rb
2. Refactor report_printer_spec.rb
3. Refactor ExpenseTrackerCLI to make it testable
4. Add specs for ExpenseTrackerCLI

## Process
1. 📚 Read the code to understand what it does and how it works.
2. 🦨 Read the code and check for design smells.
3. 🧑‍🔬 Analyze what you would have to change to implement the new requirement without refactoring the code.
4. 🧪 Write a characterization test. Take note of all design smells that you missed that made your life writing a test miserable.
5. 🔧 Refactor the code.
6. 🔧 Refactor the test.
7. 👼 Test-drive the new feature.
