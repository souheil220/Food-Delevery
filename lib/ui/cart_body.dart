import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/bloc/cartListBloc.dart';
import 'package:hello_world/ui/list_of_food.dart';
import 'cart_list_item.dart';

class CartBody extends StatelessWidget {
  final List<ListOfFood> listOfFood;
  CartBody(this.listOfFood);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustumAppBar(),
          title(),
          Expanded(
            flex: 1,
            child: listOfFood.length > 0 ? foodItemList() : noItemContaner(),
          )
        ],
      ),
    );
  }

  Container noItemContaner() {
    return Container(
      child: Center(
        child: Text(
          "No Items Left in the Cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: listOfFood.length,
      itemBuilder: (BuildContext context, int index) {
        return CartListItem(listOfFood: listOfFood[index],);
      },
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "My",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 35,
            ),
          ),
          Text(
            "Order",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class CustumAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
              child: Icon(
                CupertinoIcons.back,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              CupertinoIcons.delete,
              size: 35,
            ),
          ),
          onTap: () {},
        )
      ],
    );
  }
}
