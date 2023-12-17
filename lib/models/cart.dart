import 'package:flutter/material.dart';
import 'package:sausage_roll_app/models/food.dart';
import 'package:sausage_roll_app/models/mode.dart';

class Cart extends ChangeNotifier {
  late List<Food> foods = [];
  late double cartTotal;
  late Mode mode = Mode.eatIn;

  void setEatingMode(Mode eatingMode) {
    mode = eatingMode;
    notifyListeners();
  }

  void toggleEatingMode() {
    mode = mode == Mode.eatIn ? Mode.eatOut : Mode.eatIn;
    notifyListeners();
  }

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

  List<(Food food, int count)> getUniqueFoods() {
    List<(Food food, int count)> uniqueFoods = [];
    for (var element in foods) {
      int quantity = foods.where((el) => el.name == element.name).length;
      if (uniqueFoods
          .where((el) => el.$1.name == element.name)
          .toList()
          .isEmpty) {
        uniqueFoods.add((element, quantity));
      }
    }
    return uniqueFoods;
  }

  double calculateTotal() {
    cartTotal = 0;
    for (var element in foods) {
      if (mode == Mode.eatIn) {
        cartTotal += element.eatInPrice;
      } else {
        cartTotal += element.eatOutPrice;
      }
    }
    return cartTotal;
  }

  void clearCart() {
    foods.clear();
    notifyListeners();
  }

  String convertPriceToFormattedString(double price) {
    return '£ ${(price).toStringAsFixed(2)}';
  }
}
