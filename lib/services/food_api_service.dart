import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:sausage_roll_app/models/food.dart';

class FoodService {
  static Future<List<Food>?> getFoods() async {
    String jsonData = await rootBundle.loadString('assets/data.json');
    final List<Food> foods = [];
    final Map<String, dynamic> foodsData = json.decode(jsonData);
    for (var foodData in foodsData['data']) {
      final Food food = Food.fromJson(foodData);
      foods.add(food);
    }
    return foods;
  }
}
