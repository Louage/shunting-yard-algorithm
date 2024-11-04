# Shunting Yard Algorithm for Business Central

Menu 
[README](./README.md)  |  [disclaimer](./disclaimer.md)

## About this App

The Shunting Yard Algorithm app is designed to enhance Business Central by providing a robust and flexible way to perform complex calculations. This app leverages the Shunting Yard algorithm to parse and evaluate mathematical expressions, allowing users to determine values based on custom formulas.


## Why Use the Shunting Yard Algorithm?

In many business scenarios, users need to calculate values dynamically based on various parameters. For example, determining the loading meters for transport of a package based on its dimensions or calculating discounts, or computing financial metrics. The Shunting Yard Algorithm app simplifies these tasks by allowing users to define custom formulas that can be evaluated at runtime.
In this implementation we show how you can use this in the Unit of Measure table.
But of course, this can be used in many other scenario's.

## Key Features

- **Custom Formulas**: Define your own formulas using a simple and intuitive syntax.
- **Dynamic Calculations**: Perform calculations on the fly based on the data in your Business Central records.
- **Error Handling**: Built-in error handling ensures that invalid formulas are caught and reported.
- **Integration**: Easily integrate with existing Business Central processes and data.

## How It Works

The Shunting Yard Algorithm app uses a codeunit to parse and evaluate formulas. Here's a brief overview of the process:

1. **Define a Formula**: Users can define formulas using placeholders for field names. For example, `{{Length}} * {{Width}} * {{Height}} * 0.78 / 1000000`.
2. **Evaluate the Formula**: The app replaces the placeholders with actual values from the records and evaluates the formula using the Shunting Yard algorithm.
3. **Get the Result**: The calculated value is stored back in the record or used in further processing.

## Example Usage

Consider a scenario where you need to calculate the volume of a package. You can define a default formula as follows:

