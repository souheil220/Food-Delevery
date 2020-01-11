import 'package:hello_world/ui/list_of_food.dart';

class Commande {
  String commande;
  ListOfFood listOfFood;
  Commande(this.listOfFood, this.commande);

  String ido() {
    return listOfFood.id.toString();
  }
}
