import '../ui/list_of_food.dart';

class CartProvider {
  List<ListOfFood> listOfFoods = [];

  List<ListOfFood> addToList(ListOfFood listOfFood) {
    bool isPresent = false;
    if (listOfFoods.length > 0) {
      for (int i = 0; i < listOfFoods.length; i++) {
        if (listOfFoods[i].id == listOfFood.id) {
          isPresent = true;
          increaseItemQuantity(listOfFoods[i]);
          break;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        listOfFoods.add(listOfFood);
      }
    } else {
      listOfFoods.add(listOfFood);
    }

    return listOfFoods;
  }

  void increaseItemQuantity(ListOfFood listOfFood) =>
      listOfFood.incremantQuantity();
  void decreaseItemQuantity(ListOfFood listOfFood) =>
      listOfFood.decremantQuantity();

  List<ListOfFood> removeFromList(ListOfFood listOfFood) {
    if (listOfFood.quantity > 1) {
      decreaseItemQuantity(listOfFood);
    } else {
      listOfFoods.remove(listOfFood);
    }

    return listOfFoods;
  }
}
