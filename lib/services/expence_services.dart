import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/expence_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenceService {
  //expencevlist
  List<Expense> expensesList = [];
  // Define the key for storing expenses in shared preferences
  static const String _expensesKey = 'expenses';

  //Save the expense to shared preferences
  /// Saves an expense to the shared preferences.
  ///
  /// This method retrieves the existing list of expenses from the shared
  /// preferences, adds the new expense to this list, and then saves the
  /// updated list back to the shared preferences. A snackbar is displayed
  /// to indicate that the expense was added successfully.
  ///
  /// Parameters:
  /// - `expense`: The `Expense` object to be saved.
  /// - `context`: The `BuildContext` used to display the snackbar.
  ///
  /// Returns a `Future<void>` that completes when the operation is finished.
  Future<void> saveExpense(Expense expense, BuildContext context) async {
    //
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expensesKey);

      // Convert the existing expenses to a list of Expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJson(json.decode(e)))
            .toList();
      }

      // Add the new expense to the list
      existingExpenseObjects.add(expense);

      // Convert the list of Expense objects back to a list of strings
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJson())).toList();

      // Save the updated list of expenses to shared preferences
      await prefs.setStringList(_expensesKey, updatedExpenses);

      //show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense added successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Load the expenses from shared preferences
  /// Loads the list of expenses from shared preferences.
  ///
  /// Returns a `Future` that resolves to a list of `Expense` objects, which are
  /// loaded from the shared preferences store.
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingExpenses = prefs.getStringList(_expensesKey);

    // Convert the existing expenses to a list of Expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJson(json.decode(e)))
          .toList();
    }

    // Return the list of loaded expenses
    return loadedExpenses;
  }

  //Delete the expense from shared preferences from the id
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expensesKey);

      // Convert the existing expenses to a list of Expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJson(json.decode(e)))
            .toList();
      }

      // Remove the expense with the specified id from the list
      existingExpenseObjects.removeWhere((element) => element.id == id);

      // Convert the list of Expense objects back to a list of strings
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJson())).toList();

      // Save the updated list of expenses to shared preferences
      await prefs.setStringList(_expensesKey, updatedExpenses);

      //show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //delete all expenses from shared preferences
  Future<void> deleteAllExpenses(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_expensesKey);

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All expenses deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
