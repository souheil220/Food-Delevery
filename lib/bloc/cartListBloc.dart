import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hello_world/bloc/provider.dart';
import '../ui/list_of_food.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc extends BlocBase {
  CartListBloc();
  var _listController = BehaviorSubject<List<ListOfFood>>.seeded([]);

  CartProvider provider = CartProvider();
  //output
  Stream<List<ListOfFood>> get listStream => _listController.stream;
  //input
  Sink<List<ListOfFood>> get listSink => _listController.sink;

  addToList(ListOfFood listOfFood) {
    listSink.add(provider.addToList(listOfFood));
  }

  removeFromList(ListOfFood listOfFood) {
    listSink.add(provider.removeFromList(listOfFood));
  }

  emptyAllList(List<ListOfFood> listOfFood){
    listSink.add(provider.emptyList(listOfFood));
  }

  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }
}
