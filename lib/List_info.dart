import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:swe444/DetiledRecipe.dart';
import 'package:swe444/meal_item.dart';
import 'package:swe444/models/meals.dart';

class ListInfo extends StatefulWidget {
  final double weidth, height;

  ListInfo(this.weidth, this.height);

  @override
  State<StatefulWidget> createState() {
    return listInfo(weidth, height);
  }
}

class listInfo extends State<ListInfo> {
  final double weidth, height;
  static int category;
  List meal = [];
  listInfo(this.weidth, this.height);
  initState(){
    category=0;
  }
  @override
  Widget build(BuildContext context) {

    try {
      meal.clear();
      final currentMeal = Provider.of<List<Meal>>(context);
      for (int i = 0; i < currentMeal.length; i++) {
        if (currentMeal[i].category == category) {
          meal.add(currentMeal[i]);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return GlowingOverscrollIndicator(
      color: Color(0xfff2b705),
      axisDirection: AxisDirection.down,
      child: ListView.builder(
          itemCount: meal.length,
          itemBuilder: (context, index) {
            return MealItem(weidth, height, meal[index]);
          }),
    );
  }


}
