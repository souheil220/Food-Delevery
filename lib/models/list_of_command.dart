import '../ui/list_of_food.dart';

class ListOfCommand {
  final String amount;
  final List<ListOfFood> listOfFoods;
  final String ido;

  ListOfCommand({this.amount, this.ido, this.listOfFoods});

  static List<ListOfCommand> _list = [];

  List<ListOfCommand> addCommade(ListOfCommand listOfCommand) {
    print(_list.length);
    _list.add(listOfCommand);
    return _list;
  }
}
