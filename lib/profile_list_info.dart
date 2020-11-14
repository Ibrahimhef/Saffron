import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe444/meal_item.dart';
import 'package:swe444/models/meals.dart';

class ListInfo_profile extends StatefulWidget {
  final double weidth, height;
  int cat;
  final String MyEmail ;
  List ListOfRecipeces;

  ListInfo_profile(this.weidth, this.height, this.ListOfRecipeces, this.MyEmail);

  @override
  State<StatefulWidget> createState() {
    return listInfo_pro(weidth, height, ListOfRecipeces,MyEmail);
  }
}

class listInfo_pro extends State<ListInfo_profile> {
  final double weidth, height;
  List ListOfRecipeces;
  final String MyEmail ;
  static int cat;
  List meal = [];
  listInfo_pro(this.weidth, this.height, this.ListOfRecipeces, this.MyEmail);

  @override
  void initState() {
    cat = 0;
  }

  @override
  Widget build(BuildContext context) {
    try {
      meal.clear();
      final currentMeal = Provider.of<List<Meal>>(context);
      print(currentMeal.length);
      for (int i = 0; i < currentMeal.length; i++) {
        if (currentMeal[i].email == MyEmail && currentMeal[i].category == cat) {
          meal.add(currentMeal[i]);
        }
      }
      print(meal);
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
