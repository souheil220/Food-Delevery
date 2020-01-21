import 'package:hello_world/ui/list_of_food.dart';

class ReturnTotalAmount {
  String returnTotalAmount(List<ListOfFood> listOfFoods,totalamount,totalamount2) {
    totalamount = totalamount2;

    for (int i = 0; i < listOfFoods.length; i++) {
      totalamount = totalamount + listOfFoods[i].prix * listOfFoods[i].quantity;
    }

    return totalamount.toStringAsFixed(0);
  }
}
