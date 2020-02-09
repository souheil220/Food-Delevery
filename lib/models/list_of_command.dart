import '../ui/list_of_food.dart';

class ListOfCommand {
  final String amount;
  final List<ListOfFood> listOfFoods;
  final String ido;
  final String photor;
  final String nomr;

  ListOfCommand({this.amount, this.ido, this.listOfFoods,this.photor,this.nomr});

  static List<ListOfCommand> _list = [];

  List<ListOfCommand> addCommade(ListOfCommand listOfCommand) {
    _list.add(listOfCommand);
    return _list;
  }

  List<ListOfCommand> removeAll(List<ListOfCommand> listOfCommand) {
    return [];
  }
}
