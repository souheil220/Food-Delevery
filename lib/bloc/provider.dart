import '../ui/list_of_food.dart';

class CartProvider {
  List<ListOfFood> listOfFoods = [];

  List<ListOfFood> addToList(ListOfFood listOfFood) {
    listOfFoods.add(listOfFood);
    return listOfFoods;
  }

   List<ListOfFood> removeFromList(ListOfFood listOfFood) {
    listOfFoods.remove(listOfFood);
    return listOfFoods;
  }
}
