import 'package:flutter/material.dart';
import 'package:sausage_roll_app/models/food.dart';
import 'package:sausage_roll_app/models/unique_food.dart';

class Cart extends ChangeNotifier {
  late List<Food> foods = [];
  late double cartTotal;

  void addFood(Food food) {
    foods.add(food);
    notifyListeners();
  }

  void removeFood(Food food) {
    for (int i = 0; i < foods.length; i++) {
      if (foods[i].name == food.name) {
        foods.removeAt(i);
        break; // Stop after removing the first occurrence
      }
    }
    notifyListeners();
  }

  List<UniqueFood> getUniqueFoods() {
    List<UniqueFood> uniqueFoods = [];
    for (var element in foods) {
      int quantity = foods.where((el) => el.name == element.name).length;
      if (uniqueFoods
          .where((el) => el.food.name == element.name)
          .toList()
          .isEmpty) {
        uniqueFoods.add(UniqueFood(element, quantity));
      }
    }
    return uniqueFoods;
  }

  double calculateTotal() {
    cartTotal = 0;
    for (var element in foods) {
      cartTotal += element.eatOutPrice;
    }
    return cartTotal;
  }

  void clearCart() {
    foods.clear();
    notifyListeners();
  }

  double calculateDeliveryFee() {
    return calculateTotal() * 0.05;
  }

  double calculateGrandTotal() {
    return calculateTotal() + calculateDeliveryFee();
  }

  String convertPriceToFormattedString(double price) {
    return '£ ${(price).toStringAsFixed(2)}';
  }
}
